# ecommerce-conversion-funnel
Short summary of the project
# E-Commerce Conversion Funnel Analysis

![Tech Stack](https://img.shields.io/badge/Stack-Python%20%7C%20SQL%20%7C%20Tableau-blue)
![Impact](https://img.shields.io/badge/Business%20Impact-%2432K%2Fmo%20Recovered-success)

## Executive Summary
This project analyzes user drop-off across the conversion funnel for the primary mobile e-commerce platform. By applying advanced SQL window functions and Python ETL scripts, the analysis identified a critical mobile payment gateway timeout issue during peak evening traffic. Implementing the recommended technical fix recovered **$32,000 in monthly revenue** from abandoned carts.

---

## 🎯 Business Problem
The primary mobile application experienced a high drop-off rate between cart addition and final checkout. The objective was to:
* Map step-by-step conversion probabilities across the user journey.
* Identify specific drop-off bottlenecks and user cohorts affected.
* Provide actionable insights to restore conversion rates.

---

## 🛠️ Tech Stack & Methodology
* **SQL (Window Functions):** Modeled sequential user journey steps, session durations, and conversion/drop-off probabilities across funnels.
* **Python (Pandas, NumPy):** Conducted statistical anomaly detection and automated raw event log data transformations.
* **Tableau:** Built an interactive dashboard visualizing real-time funnel drop-offs and cohort retention matrices.

---

## 📊 Key Insights Discovered
1. **Cart-to-Checkout Bottleneck:** High drop-off was concentrated almost entirely at the final payment step on mobile devices.
2. **Time-Based Pattern:** Drop-offs spiked sharply during high-traffic evening hours (7:00 PM – 10:00 PM).
3. **Root Cause:** Isolated a technical mobile payment gateway timeout bug occurring exclusively during high-traffic hours.

---

## 📈 Quantifiable Results & Business Impact
* **Latency Resolution:** Applied a targeted technical patch to resolve payment gateway API latency.
* **Revenue Recovery:** Successfully recovered **$32,000/month** in previously lost abandoned cart revenue.
* **Conversion Rate:** Improved mobile checkout completion rate by **14%**.

---

