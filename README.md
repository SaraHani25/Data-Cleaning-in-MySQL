#Data Cleaning Project - Layoffs Data
This project focuses on cleaning and organizing a dataset related to layoffs. The data cleaning steps include identifying and removing duplicate records to ensure data quality and accuracy. The process was executed in SQL and included the following key steps:

1-**Staging Table Creation**: Temporary staging tables (layoffs_staging and layoffs_staging2) were created to facilitate data manipulation without impacting the original data source.

2-**Data Insertion and Duplicate Identification**: Data from the main layoffs table was copied into layoffs_staging. Using the ROW_NUMBER function, potential duplicates were identified based on key columns such as company, industry, and date.

3-**Filtering Duplicates**: Rows marked with duplicate row numbers were filtered out to ensure that only unique records were retained.

4-**Final Clean Dataset**: The cleaned, deduplicated data was then transferred to layoffs_staging2, making it ready for further analysis and visualization.

This process ensures a high-quality dataset by handling redundancies and improving data reliability for subsequent stages of analysis.

