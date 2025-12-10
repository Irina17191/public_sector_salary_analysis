
# Public Sector Salary Analysis

This repository contains a project analyzing **average salaries** of public sector employees in **ministries** and **central executive bodies (CEBs)** in Ukraine. The analysis is based on publicly available data from the **Unified State Register of Declarations of Persons Authorized to Perform State or Local Government Functions** (Register of Declarations).

Dashboards and visualizations were created using **Apache Superset**, while data extraction, cleaning, and aggregation were performed with **SQL**.
Superset dashboards include **interactive filters** for deeper data exploration.  

---

## 🛠 Technologies

**SQL (PostgreSQL):**  
- CTEs for structured pipeline stages  
- Window functions (NTILE, ROW_NUMBER)  
- Subqueries for filtering and validation  
- Regex-based text cleaning  
- Conditional aggregation  
- JOINs across multiple declaration-related tables  
- Data quality checks (year completeness, duplicate main salaries, invalid income values)

**Apache Superset** — interactive dashboards and visualizations, multi-level filters    
**GitHub** — version control and project sharing

---


## 📊 Dashboard Visualizations

The following charts are included. Click each to view the screenshot (filters can be applied to each chart separately or to the whole dashboard): 
**Note:** The Superset dashboard includes **interactive filters** for **year** and **employee post category**, which are not visible in these static screenshots.
Screenshots provide a preview but interactivity is available in Superset.


### 1. Average Salary Analysis Across Ministries
![Average Salary Analysis Across Ministries](charts/1%20Average%20Salary%20Analysis%20Across%20Ministries.jpg)
*Distribution of average monthly salaries by ministry.*

---

### 2. Average Salary Analysis Central Executive Bodies
![Average Salary Analysis Central Executive Bodies](charts/2%20Average%20Salary%20Analysis%20Central%20Executive%20Bodies.jpg)
*Distribution of average monthly salaries by central executive body.*

---

### 3. Ministries Dynamics of Average Salary by Year
![Ministries Dynamics of Average Salary by Year](charts/3%20Ministries%20Dynamics%20of%20Average%20Salary%20by%20Year.jpg)
*Trends of average salaries in ministries over the years.*

---

### 4. Central Executive Bodies Salary Dynamics by Year
![Central Executive Bodies Salary Dynamics by Year](charts/4%20Central%20Executive%20Bodies%20Salary%20Dynamics%20by%20Year.jpg)
*Trends of average salaries in central executive bodies over the years.*

> **Note:** The Superset dashboard includes **interactive filters** for **year** and **employee post category**, which are not visible in these static screenshots.

---

## 📝 Data Source & Description

- **Data Source:** [Unified State Register of Declarations](https://public.nazk.gov.ua/)  
- **Scope:** Ministries and Central Executive Bodies in Ukraine  
- **Data Features:** Employee monthly income (converted from annual), post categories, organization identifiers (EDRPOU codes)  
- **Filtering:** Only relevant income types included; duplicate salaries removed, verified that each employee worked the *entire calendar year*, ensuring that only complete-year salary data was analyzed
- **Segmentation:** Income quintiles (NTILE(5)), focused on the 2nd, 3rd, and 4th quintiles

---

## 📁 Repository Structure

```
public_sector_salary_analysis/
├─ charts/                     # Dashboard screenshots
│  ├─ 1 Average Salary Analysis Across Ministries.jpg
│  ├─ 2 Average Salary Analysis Central Executive Bodies.jpg
│  ├─ 3 Ministries Dynamics of Average Salary by Year.jpg
│  └─ 4 Central Executive Bodies Salary Dynamics by Year.jpg
│
├─ sql/                        # SQL scripts for data preparation
│  ├─ ministries_salary.sql
│  └─ central_executive_bodies_salary.sql
│
└─ README.md                   # Project description and visualizations
```

---

## 🔄 SQL Pipeline

### 1. Preparation of Organization Reference Tables
- Compiled EDRPOU lists for ministries and central executive bodies  
- Verified correctness of every organization  
- Joined these reference tables with the main declaration dataset

### 2. Base Extraction
- Selected key fields from declarations and revenue tables  
- Filtered only annual declarations (2022–2024)  
- Converted annual salary values into monthly equivalents

### 3. Duplicate Salary Removal
- Identify employees with multiple main salaries  
- Removed duplicates to avoid inflated income statistics

### 4. Quartile Segmentation
- Applied NTILE(5) over monthly income  
- Focused on 2nd–4th quintiles (avoid extreme outliers)

### 5. Final Aggregation
- Grouped by ministry/CEB and post category  
- Calculated counts, means, and medians  
- Excluded irrelevant / misclassified organizations


---

## 🔗 References

- [Unified State Register of Declarations](https://public.nazk.gov.ua/)  
- [Apache Superset Documentation](https://superset.apache.org/)

