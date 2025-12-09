
# Public Sector Salary Analysis

This repository contains a project analyzing **average salaries** of public sector employees in **ministries** and **central executive bodies (CEBs)** in Ukraine. The analysis is based on publicly available data from the **Unified State Register of Declarations of Persons Authorized to Perform State or Local Government Functions** (Register of Declarations).

Dashboards and visualizations were created using **Apache Superset**, while data extraction, cleaning, and aggregation were performed with **SQL**.
Superset dashboards include **interactive filters** for deeper data exploration.  



## 📊 Dashboard Visualizations

The following charts are included. Click each to view the screenshot:

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

## 🛠 Technologies

- **SQL** — for data extraction, cleaning, aggregation, and analysis  
- **Apache Superset** — for interactive dashboards and visualizations  
- **GitHub** — for version control and project sharing  

---

## 📝 Data Source & Description

- **Data Source:** [Unified State Register of Declarations](https://public.nazk.gov.ua/)  
- **Scope:** Ministries and Central Executive Bodies in Ukraine  
- **Data Features:** Employee monthly income (converted from annual), post categories, organization identifiers (EDRPOU codes)  
- **Filtering:** Only relevant income types included; duplicate salaries removed  
- **Segmentation:** Income quintiles used to focus on 2nd, 3rd, and 4th quintiles  

---

## 📁 Repository Structure

public_sector_salary_analysis/
├─ charts/                      # Dashboard screenshots
│ ├─ ministries_avg_salary.jpg
│ ├─ ministries_salary_trend.jpg
│ ├─ ceb_avg_salary.jpg
│ └─ ceb_salary_trend.jpg
├─ sql/                         # SQL scripts for data preparation
│ ├─ ministries_salary.sql
│ └─ central_executive_bodies_salary.sql
└─ README.md                    # Project description and visualizations




---

## 🧩 SQL Pipeline Overview

1. **Base Extraction:**  
   - Select relevant fields from general and revenue tables  
   - Filter annual declarations (2022–2024)  
   - Convert annual salaries to monthly  

2. **Duplicate Salary Removal:**  
   - Identify employees with multiple main salaries  
   - Remove duplicates to avoid bias  

3. **Quartile Segmentation:**  
   - Assign employees to income quintiles (NTILE(5))  
   - Focus analysis on 2nd, 3rd, and 4th quintiles  

4. **Final Aggregation:**  
   - Group by ministry/CEB and post category  
   - Compute **count**, **average**, and **median salaries**  
   - Exclude irrelevant or outlier organizations  

---

## 📌 Notes

- Project is **fully reproducible** using the provided SQL scripts.  
- Superset dashboards include **interactive filters** for deeper data exploration.  
- Screenshots provide a preview but interactivity is available in Superset.

---

## 🔗 References

- [Unified State Register of Declarations](https://public.nazk.gov.ua/)  
- [Apache Superset Documentation](https://superset.apache.org/)

