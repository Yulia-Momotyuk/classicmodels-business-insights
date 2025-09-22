[![View Repositories](https://img.shields.io/badge/View-My_Repositories-blue?logo=GitHub)](https://github.com/Yulia-Momotyuk?tab=repositories)
[![View My Profile](https://img.shields.io/badge/View-My_Profile-green?logo=GitHub)](https://github.com/Yulia-Momotyuk)
# ClassicModels — Sales Insights & Business Analytics  

## Project Overview  
This project analyzes the **[ClassicModels](https://www.mysqltutorial.org/mysql-sample-database.aspx)** dataset, focusing on products, customers, markets, revenue dynamics, and payment discipline.  
The goal is to generate **business insights** that support strategic decision-making:  
- Which products and customers drive the majority of revenue.  
- Which markets have the highest potential.  
- How seasonality affects sales.  
- What financial risks are caused by payment delays.  

---

## Resources  
- SQL queries: `sql/queries.sql`  
- Jupyter Notebook with analysis: `notebooks/ClassicModels_Analysis.ipynb`  
- Visualizations: `images/`  

---

## Table of Contents  
1. Project Overview  
2. Technologies Used  
3. Key Features  
4. Data Overview  
5. Methodology  
6. Key Insights  
7. Installation  

---

## 1. Project Overview  
The project includes:  
- Analysis of Top-10 products by revenue and profitability, validation of Pareto principle.  
- Customer segmentation (one-time vs repeat, RFM analysis).  
- Geographic breakdown of revenues and AOV (mass vs premium markets).  
- Revenue dynamics, MoM changes, and seasonality.  
- Payment discipline and liquidity risks.  

---

## 2. Technologies Used  
- **Programming Language:** Python  
- **Libraries:**  
  - pandas, numpy (data processing)  
  - matplotlib, seaborn (visualization)  
  - scipy (statistical analysis)  
- **Database:** MySQL  
- **SQL ORM:** SQLAlchemy (for database connection and query execution in Python)  
- **Development Environment:** Jupyter Lab  

---

## 3. Key Features  
1. **Products & Profitability**  
   - Top-10 products by revenue.  
   - Pareto analysis (20% → 80%).  
   - Profit margin calculation.  
2. **Customers**  
   - Top-10 customers.  
   - One-time vs repeat buyers.  
   - RFM segmentation.  
3. **Markets & Geography**  
   - Top-10 countries by revenue.  
   - Average order value (AOV).  
   - Mass vs premium markets.  
4. **Revenue Dynamics & Seasonality**  
   - Monthly revenues.  
   - MoM changes.  
   - Heatmap of seasonality.  
5. **Payments**  
   - Median payment delays.  
   - Top-10 customers with the longest delays.  
   - Boxplot for outliers.  

---

## 4. Data Overview  
The ClassicModels database contains:  
- **products** — assortment, category, price, cost.  
- **customers** — client information (name, country, contacts).  
- **orders, orderdetails** — orders and order details.  
- **payments** — payment dates and amounts.  

---

## 5. Methodology  
1. **Data Extraction:** SQL queries executed via SQLAlchemy.  
2. **Data Processing:** Calculation of revenue, profit, margins, AOV, and payment delays.  
3. **Analysis:** Pareto, RFM segmentation, revenue trends, seasonality.  
4. **Visualization:** bar charts, line plots, heatmaps, boxplots.  

---

## 6. Key Insights  
- ~65% of the product assortment generates 80% of revenue → more balanced than the classic 80/20 rule.  
- 99% of customers are repeat buyers, but only 60 out of 98 generate 80% of revenue.  
- USA is the largest market ($3.27M), while Switzerland, Italy, and UK show the highest AOV ($30–55K).  
- Strong seasonal peaks occur in November–December (> $1M/month).  
- Median payment delay = 114 days, with some clients systematically delaying >300 days.  

---

## 7. Installation  
To run this project locally:  
```bash
git clone https://github.com/Yulia-Momotyuk/classicmodels-business-insights.git
cd classicmodels-sales-insights
```
### Open Notebook

Open **[`notebooks/ClassicModels_Analysis.ipynb`](notebooks/ClassicModels_Analysis.ipynb)** in Jupyter Lab.

---

### Business & Technical Goals  

- **Business Goal:** Identify key revenue drivers, customer segments, seasonal patterns, and payment risks to improve profitability and financial stability.  
- **Technical Goal:** Extract data from MySQL, process using Python and SQLAlchemy, and deliver insights through analysis, visualization, and storytelling in Jupyter Notebook.  
## 📬 Contact

[LinkedIn](https://www.linkedin.com/in/yuliia-kononchuk-78913633b/) | [Email](mailto:kononchuk.yuliia@gmail.com)

---
> **Author**: _Yuliia Kononchuk_  
> _This repository is part of my personal learning journey and professional portfolio._ 

