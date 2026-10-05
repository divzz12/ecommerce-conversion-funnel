import pandas as pd
import numpy as np

def detect_gateway_timeouts(df: pd.DataFrame) -> pd.DataFrame:
    """
    Isolates mobile payment gateway timeouts during peak hours.
    """
    # Filter for Mobile Checkout Events
    mobile_checkout = df[(df['device_type'] == 'Mobile') & (df['event'] == 'payment_submit')]
    
    # Extract hour of the day
    mobile_checkout['hour'] = pd.to_datetime(mobile_checkout['timestamp']).dt.hour
    
    # Calculate Latency & Failure Rate
    hourly_metrics = mobile_checkout.groupby('hour').agg(
        total_attempts=('transaction_id', 'count'),
        avg_latency_ms=('response_time_ms', 'mean'),
        timeout_failures=('status', lambda x: (x == 'GATEWAY_TIMEOUT').sum())
    ).reset_index()
    
    hourly_metrics['failure_rate_%'] = (hourly_metrics['timeout_failures'] / hourly_metrics['total_attempts']) * 100
    
    # Flag evening peak hour anomalies (7 PM - 10 PM)
    hourly_metrics['is_anomaly'] = (hourly_metrics['hour'].between(19, 22)) & (hourly_metrics['failure_rate_%'] > 25.0)
    
    return hourly_metrics

if __name__ == "__main__":
    df = pd.read_csv("data/raw/mobile_events.csv")
    report = detect_gateway_timeouts(df)
    print(report[report['is_anomaly']])
