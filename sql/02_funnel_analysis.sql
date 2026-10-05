-- E-Commerce Funnel Analysis: Step Probabilities & Window Functions
WITH UserEvents AS (
    SELECT 
        user_id,
        session_id,
        event_name,
        device_type,
        created_at,
        LEAD(event_name) OVER (PARTITION BY session_id ORDER BY created_at) AS next_event,
        LEAD(created_at) OVER (PARTITION BY session_id ORDER BY created_at) AS next_event_time
    FROM raw_events
    WHERE created_at >= '2026-01-01'
),
FunnelSteps AS (
    SELECT 
        session_id,
        device_type,
        MAX(CASE WHEN event_name = 'page_view' THEN 1 ELSE 0 END) AS step_1_view,
        MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS step_2_cart,
        MAX(CASE WHEN event_name = 'checkout_start' THEN 1 ELSE 0 END) AS step_3_checkout,
        MAX(CASE WHEN event_name = 'payment_success' THEN 1 ELSE 0 END) AS step_4_payment
    FROM UserEvents
    GROUP BY session_id, device_type
)
SELECT 
    device_type,
    COUNT(session_id) AS total_sessions,
    SUM(step_2_cart) AS cart_additions,
    SUM(step_3_checkout) AS checkout_starts,
    SUM(step_4_payment) AS completed_payments,
    ROUND(SUM(step_3_checkout)::NUMERIC / NULLIF(SUM(step_2_cart), 0) * 100, 2) AS cart_to_checkout_rate%,
    ROUND(SUM(step_4_payment)::NUMERIC / NULLIF(SUM(step_3_checkout), 0) * 100, 2) AS checkout_to_pay_rate%
FROM FunnelSteps
GROUP BY device_type;
