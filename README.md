# 📊 Investor Behavior & Risk Analytics — Power BI + MySQL

An end-to-end data analytics project analyzing investor behavior, risk appetite, and investment patterns across demographics and asset classes — combining **MySQL** for data exploration and **Power BI** for interactive visualization.

---

## 🗂️ Project Overview

This project explores how individual investors behave across different financial avenues, risk categories, and demographic segments. MySQL was used for initial data exploration and insight generation, with findings then visualized in a Power BI dashboard.

---

## 📁 Files

| File | Description |
|------|-------------|
| `finance.pbix` | Power BI Desktop report — open with Power BI Desktop (free) |
| `finance_analysis.sql` | MySQL queries for data exploration and analysis |

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| MySQL | Data exploration, aggregation, window functions, subqueries |
| Power BI Desktop | Data modeling, DAX measures, interactive visualization |
| Power Query (M) | Data transformation and cleaning |
| DAX | Calculated columns, KPIs, Share % measures |

---

## 🗄️ MySQL Analysis

The SQL file covers 5 areas of analysis:

| Section | Queries |
|---------|---------|
| Setup | Added primary key column |
| Demographic Analysis | Average age by avenue, investor age group distribution |
| Risk Analysis | Investor count by risk category (High / Moderate / Low) |
| Investment Preference | Gender % split by avenue, mutual fund ranking with `DENSE_RANK()` |
| Return Expectation | Correlated subquery to find high-expectation investors older than their gender average |

**SQL concepts used:** `GROUP BY`, `CASE WHEN`, window functions (`OVER`, `PARTITION BY`, `DENSE_RANK()`), correlated subqueries, `ROUND()`, `ORDER BY`

---

## 📌 Power BI Dashboard Pages

### Page 1 — Overview
- **KPI Cards** — Total Investors, Average Investor Age, Most Expected Return
- **Donut Chart** — Investment Avenue Distribution
- **Clustered Column Chart** — Return Expectations by Investor Count
- **100% Stacked Column Chart** — Risk Category by Gender
- **Line Chart** — Average Mutual Fund Allocation by Avenue
- **Column Chart** — Gender Split by Investment Avenue
- **Tables** — Why Investors Choose Equity · Avenue Share & Monitoring Frequency
- **Slicers** — Filter by Age and Investment Monitoring frequency

### Page 2 — Drill-down
- **Decomposition Tree** — Investor Count Breakdown by Avenue → Gender → Age → Return Expectation
- **Summary Table** — Avenue share % and monitoring habits

---

## 📊 Key Insights

- Investors with **high risk tolerance** are significantly more likely to invest in equity
- **Mutual Funds** attract the most consistent monitoring behavior across all age groups
- **Return expectations** vary sharply by gender and age bracket
- Older-than-average investors still expect **high returns (20%–40%)**, especially in equity
- Younger investors (under 30) show a higher preference for equity over fixed deposits

---

## 📂 Dataset

| Attribute | Detail |
|-----------|--------|
| Table | `finance_data` |
| Key columns | `Avenue`, `gender`, `age`, `Expect`, `Equity_Market`, `Invest_Monitor`, `Mutual_Funds`, `Reason_Equity` |

> **Note:** Replace with actual dataset source (e.g. Kaggle link or survey name) if applicable.

---

## 🚀 How to Use

**Power BI dashboard:**
1. Install [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (free)
2. Download `finance.pbix` and open it
3. Use the Age and Investment Monitor slicers to filter the report

**SQL queries:**
1. Import your dataset into MySQL as `finance_data`
2. Open `finance_analysis.sql` in MySQL Workbench or any SQL client
3. Run queries section by section — each has a comment explaining what it does

---

## 📷 Screenshots



---

## 👤 Author

Gandla Vyshnavi  
Data Analyst | Power BI · MySQL  
[LinkedIn](www.linkedin.com/in/gandla-vyshnavi) · [GitHub](https://github.com/vysh611)

---

## 📄 License

This project is for portfolio and educational purposes.
