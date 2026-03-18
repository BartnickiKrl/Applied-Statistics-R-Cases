# Applied Statistics R Cases

This repository contains a collection of practical statistical analyses and data science projects developed during my studies at **AGH University of Krakow**. Each case study demonstrates a different stage of the data pipeline: from preprocessing and exploratory data analysis (EDA) to statistical inference and predictive modeling.

## Skills & Methodology
In these projects, I apply the following techniques:
- **Statistical Testing:** Shapiro-Wilk, Pearson/Spearman correlation, Hypothesis testing.
- **Data Preprocessing:** Cleaning, transforming, and integrating raw datasets for analysis.
- **Predictive Modeling:** Linear Regression (OLS) and trend estimation.
- **Visualization:** Advanced plotting using `ggplot2` and base R graphics.

---

## Case Studies Overview

### 1. Automotive Engineering: Horsepower vs. Gear Ratio
**Dataset:** `mtcars`  
An analysis of the relationship between engine power (`hp`) and the rear axle ratio (`drat`) to understand how mechanical specifications influence vehicle performance.
* **Focus:** Correlation analysis and normality testing.
* **Key Insight:** Identified a strong negative correlation, reflecting engineering trade-offs between high-end power and acceleration efficiency.
* [View Folder](./case-01-automotive-correlation/)

### 2. Global Demographics: Life Expectancy vs. Population
**Dataset:** `gapminder` (Year: 1987)  
Investigating whether a country's population size correlates with the average life expectancy of its citizens.
* **Focus:** Understanding socio-economic impacts on health metrics across different global regions.
* **Key Insight:** The study evaluates if rapid population growth in developing nations poses challenges to healthcare quality and longevity.
* [View Folder](./case-02-life-expectancy-gapminder/)

### 3. Titanic: Survival Analysis & Data Preprocessing
**Dataset:** `titanic_new.csv`  
A deep dive into the passenger manifest of the RMS Titanic to identify factors that influenced survival rates during the 1912 disaster.
* **Focus:** Professional data preprocessing, cleaning, and feature preparation.
* **Key Insight:** Demonstrates the importance of data cleaning in building reliable models to explain mortality patterns.
* [View Folder](./case-03-titanic-data-preprocessing/)

### 4. Retail Analytics: Sales Prediction Model
**Dataset:** `sklep77.xlsx`  
Developing a linear regression model to predict sales volume based on customer traffic.
* **Focus:** Linear Regression (`lm`), predictive analytics, and trend visualization.
* **Key Insight:** Beyond analyzing current data, the project includes calculating theoretical sales values for specific customer traffic scenarios using the trained model.
* [View Folder](./case-04-sales-regression-model/)

---

## Project Structure
Each folder typically includes:
- The **R Script** or **RMarkdown** file containing the source code.
- A **Final Report (PDF)** with detailed interpretations, charts, and statistical conclusions.
- The **Dataset** (unless is from R library).

---
## Copyright

Copyright (c) 2025 Karol Bartnicki
All rights reserved.
