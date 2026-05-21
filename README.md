# presidents-data-cleaning-excel-mysql
Data cleaning project where the same US Presidents dataset was cleaned using both Excel and MySQL, then exported as a final cleaned CSV.

# US Presidents Data Cleaning with Excel and MySQL

## Project Overview

This project focuses on cleaning the same US Presidents dataset using two different tools: Excel and MySQL.

The main goal was to practise and compare two common data cleaning workflows:

- A spreadsheet-based workflow using Excel.
- A SQL-based workflow using MySQL.

The final cleaned dataset was exported from MySQL and included in this repository together with the original raw dataset, the Excel cleaning workbook and the SQL cleaning script.

## Tools Used

- Excel
- MySQL
- GitHub

## Dataset

The dataset contains information about US Presidents, including:

- President name
- Prior role
- Political party
- Vice President
- Salary
- Date updated
- Date created

## Project Objective

The objective of this project was not to create a dashboard or perform business analysis, but to focus specifically on data cleaning and data preparation.

This project demonstrates how the same dataset can be cleaned using both Excel and MySQL, showing flexibility with different tools commonly used in data analyst roles.

## Cleaning Workflow

The dataset was cleaned twice:

1. First using Excel.
2. Then using MySQL.

The final cleaned CSV was exported from MySQL after completing the SQL cleaning process.

## Excel Cleaning Process

In Excel, I worked on a separate cleaning sheet to transform and standardise the dataset.

The cleaning tasks included:

- Standardising president names.
- Fixing inconsistent uppercase/lowercase formatting.
- Cleaning extra spaces using trimming techniques.
- Reviewing party values and inconsistent text.
- Cleaning Vice President names.
- Formatting salary values.
- Standardising date columns.
- Creating a cleaner working version of the dataset.

## MySQL Cleaning Process

In MySQL, I repeated the cleaning workflow using SQL queries to make the process more structured and reproducible.

The SQL cleaning process included:

- Importing the raw dataset into MySQL.
- Creating a working table for cleaning.
- Standardising text fields.
- Fixing inconsistent values.
- Cleaning and preparing salary fields.
- Formatting date columns.
- Exporting the final cleaned dataset as a CSV file.

## Files Included

- `data/raw/`: original raw dataset.
- `data/cleaned/`: final cleaned dataset exported from MySQL.
- `excel/`: Excel workbook containing the cleaning process.
- `sql/`: MySQL cleaning script.

## Why This Project Matters

Although this project does not include dashboards or insights, it focuses on one of the most important parts of a data analyst workflow: preparing raw data before analysis.

Cleaning data correctly is essential because poor data quality can lead to inaccurate analysis, misleading conclusions and unreliable dashboards.

## Key Skills Demonstrated

- Data cleaning
- Data preparation
- Excel transformations
- SQL transformations
- Text standardisation
- Date formatting
- Salary/value cleaning
- Dataset export
- Reproducible cleaning workflow

## Conclusion

This project helped me practise the same data cleaning process using both Excel and MySQL.

By cleaning the dataset in two different tools, I reinforced my understanding of data quality, transformation logic and the importance of preparing clean datasets before performing analysis.
