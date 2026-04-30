# Customers-Trend-Analysis-Python-SQL-PowerBI
# 🛍️ Customers Trend Analysis — Python | SQL | Power BI

A complete end-to-end data analytics project analyzing customer shopping behaviour using **Python**, **MySQL**, and **Power BI**.

---

## 📌 Project Overview

This project simulates a real-world business scenario where a retail company wants to understand its customers' shopping patterns, identify high-value customers, and make data-driven decisions to improve revenue and customer retention.

The project covers the full data analytics workflow:
- **Data Cleaning & Exploration** using Python (Pandas)
- **Data Storage & Business Queries** using MySQL
- **Interactive Dashboard** using Power BI

---

## 🗂️ Dataset

| Detail | Info |
|--------|------|
| **Source** | Kaggle — Customer Shopping Behavior Dataset |
| **Records** | 3,900 rows |
| **Columns** | 18 columns |
| **Format** | CSV |

### Columns Include:
`customer_id`, `age`, `gender`, `item_purchased`, `category`, `purchase_amount`, `location`, `size`, `color`, `season`, `review_rating`, `subscription_status`, `shipping_type`, `discount_applied`, `previous_purchases`, `payment_method`, `frequency_of_purchases`

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| **Python (Pandas)** | Data loading, cleaning, feature engineering |
| **MySQL Workbench** | Data storage and business analysis queries |
| **Power BI Desktop** | Interactive dashboard and visualization |
| **SQLAlchemy** | Python to MySQL connection bridge |
| **VS Code + Jupyter** | Development environment |

---

## 📁 Project Structure

```
📦 Customers-Trend-Analysis-Python-SQL-PowerBI
 ├── 📓 Customers Behaviour Analysis.ipynb   # Python data cleaning & prep
 ├── 🗄️ Customer_Behavior_Analysis-MYSQL.sql  # SQL business queries
 ├── 📊 customer_behavior_dashboard.pbix     # Power BI dashboard
 ├── 📄 Business Problem Document.pdf        # Project problem statement
 ├── 📄 Customer Shopping Behavior Analysis.pdf  # Project report
 ├── 📑 Customer-Shopping-Behavior-Analysis.pptx # Presentation slides
 ├── 🗜️ archive.zip                          # Raw dataset
 └── 📋 README.md
```

---

## 🐍 Step 1 — Python (Data Cleaning & Preparation)

### What was done:
- Loaded raw CSV data into a Pandas DataFrame
- Explored dataset structure using `df.info()`, `df.describe()`
- Identified and filled **37 missing values** in `Review Rating` using category-wise median
- Standardized all column names to lowercase with underscores
- Renamed `purchase_amount_(usd)` → `purchase_amount`
- Created new feature: **`age_group`** column (`young_adult`, `adult`, `middle_aged`, `senior`)
- Created new feature: **`purchase_frequency_days`** (converted text frequency to numeric days)
- Verified `discount_applied` and `promo_code_used` were identical → dropped redundant column
- Pushed cleaned data into MySQL using SQLAlchemy

### Key Libraries:
```python
import pandas as pd
import mysql.connector
from sqlalchemy import create_engine
```

---

## 🗄️ Step 2 — MySQL (Business Analysis Queries)

### Database:
```
Database : Customers_Behaviour_Analysis
Table    : customer_shopping_behavior
```

### Business Questions Answered:

| # | Business Question | SQL Concept Used |
|---|-------------------|-----------------|
| 1 | Total purchased based on gender? | `GROUP BY`, `SUM` |
| 2 | Customers spending above average even with discount? | Subquery, `WHERE` |
| 3 | Top 5 products by average review rating? | `AVG`, `LIMIT` |
| 4 | Avg spending by shipping type (Express vs Standard)? | `WHERE IN`, `AVG` |
| 5 | Do subscribed customers spend more? | `GROUP BY`, `SUM`, Subquery |
| 6 | Top 5 products with highest sales when discount applied? | `CASE WHEN`, `SUM` |
| 7 | Classification of customers (New / Returning / Loyal)? | `CTE`, `CASE WHEN` |
| 8 | Top 3 most sold products from each category? | `CTE`, `ROW_NUMBER()`, `PARTITION BY` |
| 9 | Are repeat buyers (5+ purchases) likely to subscribe? | `WHERE`, `GROUP BY` |
| 10 | Revenue generated from different age groups? | `GROUP BY`, `SUM` |

---

## 📊 Step 3 — Power BI Dashboard

### Connection:
```
Server   : localhost
Database : Customers_Behaviour_Analysis
Table    : customer_shopping_behavior
```

### Dashboard Pages:

**Page 1 — Sales Overview**
- Total Revenue (KPI Card)
- Total Customers (KPI Card)
- Average Purchase Amount (KPI Card)
- Revenue by Category (Bar Chart)
- Revenue by Gender (Pie Chart)
- Revenue by Season (Bar Chart)

**Page 2 — Customer Analysis**
- Revenue by Age Group (Bar Chart)
- Subscribed vs Non-Subscribed Customers (Donut Chart)
- Avg Spending by Shipping Type (Bar Chart)
- Top Products Summary (Table)

**Page 3 — Discount & Loyalty**
- Top Products Sold With Discount (Bar Chart)
- Avg Spend: Subscribed vs Non-Subscribed (Column Chart)
- Repeat Buyers Subscription Rate (Bar Chart)

### Slicers (Filters):
- Season
- Gender
- Category

---

## 🔍 Key Findings

| # | Finding | Business Recommendation |
|---|---------|------------------------|
| 1 | Male customers generate higher total revenue | Target male audience in marketing campaigns |
| 2 | High-value customers spend above average even with discounts | Retain these customers with loyalty programs |
| 3 | Express shipping attracts higher value purchases | Invest more in faster delivery infrastructure |
| 4 | Subscribed customers cover only **26.88%** of total revenue | Redesign subscription benefits to increase value |
| 5 | Even repeat buyers (5+ purchases) are not subscribing | Offer exclusive perks to convert loyal buyers |
| 6 | Top products heavily rely on discounts for sales | Evaluate discount dependency and reduce margins risk |
| 7 | Majority of customers are **New** (1 purchase only) | Focus on customer retention and acquisition strategy |
| 8 | Youth age group (`young_adult`) generates highest revenue | Continue social media and digital marketing investment |

---

## ⚙️ How to Run This Project

### 1. Clone the Repository
```bash
git clone https://github.com/kishan-gautam/Customers-Trend-Analysis-Python-SQL-PowerBI.git
```

### 2. Run Python Notebook
- Open `Customers Behaviour Analysis.ipynb` in VS Code or Jupyter
- Make sure MySQL is running locally
- Update credentials if needed:
```python
conn = mysql.connector.connect(
    host="localhost",
    user="your_username",
    password="your_password",
    database="Customers_Behaviour_Analysis"
)
```
- Run all cells

### 3. Run SQL Queries
- Open `Customer_Behavior_Analysis-MYSQL.sql` in MySQL Workbench
- Run all queries

### 4. Open Power BI Dashboard
- Open `customer_behavior_dashboard.pbix` in Power BI Desktop
- Update MySQL connection credentials if needed
- Refresh data

---

## 📋 Requirements

```
Python        3.x
pandas
mysql-connector-python
sqlalchemy
MySQL         8.0+
Power BI Desktop (latest)
MySQL Connector/ODBC (for Power BI)
```

Install Python libraries:
```bash
pip install pandas mysql-connector-python sqlalchemy
```

---

## 👤 Author

**Kishan Gautam**  
📅 April 2026  
🔗 [GitHub Profile](https://github.com/kishan-gautam)

---

## 📄 License

This project is open source and available for learning and portfolio purposes.
