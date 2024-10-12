# Cyclistic Bike-Share Data Analysis
## Project Overview
This project analyzes 12 months of bike-share data from Cyclistic, a fictional bike-share company in Chicago, to identify trends in usage between casual riders and annual members. The insights derived aim to inform a data-driven marketing strategy to encourage casual riders to convert to annual memberships.

## Table of Contents
- [Project Overview](#project-overview)
- [Data Source](#data-source)
- [Tools and Skills](#tools-and-skills)
- [Process](#process)
  - [1. Data Loading](#1-data-loading)
  - [2. Data Cleaning](#2-data-cleaning)
  - [3. Analysis](#3-analysis)
  - [4. Visualization](#4-visualization)
- [Key Findings](#key-findings)
- [Recommendations](#recommendations)
- [File Structure](#file-structure)

## Data Source
The data used in this project comes from the Cyclistic bike-share historical data, publicly available and provided by Motivate International Inc. The dataset contains millions of records with details such as trip duration, start and end stations, user type, and ride time.

>**Note**: Personally identifiable information (PII) has been removed from the data to ensure privacy.

## Tools and Skills
- **Database**: Microsoft SQL Server Management Studio (SSMS)
- **Analysis**: SQL for data cleaning and querying
- **Visualization**: Power BI for creating interactive dashboards
- **Skills Applied**: Data wrangling, trend analysis, visualization, report writing

## Process 

### 1. Data Loading
The 12-month CSV files were loaded into a SQL Server database using BULK INSERT statements, creating a table structure suited for analysis.

### 2. Data Cleaning
Data cleaning steps included:
- Converting DateTime formats to extract hours, weekdays, and months for trend analysis
- Addressing null values, duplicates, and data type inconsistencies
- Filtering out records with data integrity issues

### 3. Analysis
Key SQL queries were run to identify trends such as:
- Most popular start and end stations
- Ride times by hour, day of the week and month
- Comparison of usage patterns between casual riders and annual members

### 4. Visualization
Using Power BI, several visualizations were created to support data insights, including:
- **Ride Patterns**: Bar Chart for average trip duration and bike type preference
- **Usage Trends**: Line charts comparing hourly, daily and monthlyridership
- **Station Popularity**: Bar chart showing the top stations

## Key Findings
- Casual riders primarily use Cyclistic bikes on weekends and during midday, suggesting a recreational usage pattern.
- Annual members have more consistent usage throughout the week, indicating usage for commuting.

## Recommendations
1. **Introduce a Weekend Membership Plan**: Target casual riders with a plan that offers weekend discounts, as they are more likely to use bikes for leisure.
2. **Implement Targeted Marketing**: Schedule marketing campaigns during peak usage times for casual riders to maximize engagement.
3. **Use Social Media Geotargeting**: Promote memberships to casual riders in high-usage areas, emphasizing the convenience and savings of an annual membership.

## File Structure
[`CyclisticTrips.sql`](CyclisticTrips.sql): SQL script for database, table creation, clean,transform data, data analysis and trend identification
[CylisticTrip_Viz](CyclisticTrip_Viz.pdf): Power BI report with visualizations and dashboards
[README.md](README.md): Project documentation

## Acknowledgments
Special thanks to Google Data Analytics Course and Motivate International Inc. for providing the dataset and to OpenAI for assistance with project guidance.
