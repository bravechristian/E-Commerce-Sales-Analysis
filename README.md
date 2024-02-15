# E-Commerce Sales Analysis
<br/><br/>
### Overview
The goal of this e-commerce sales analysis project is to glean insightful information from the supplied sales data. This project uses data analytics and visualization tools to optimize sales effectiveness, enhance customer satisfaction, and stimulate corporate growth. The goal is to deliver actionable recommendations. <br/><br/>

### Data Source
The "salesData.csv" file, which includes comprehensive details about each sale the company has made, is the main dataset used in this analysis.
<br/><br/>

### Tools & Software
-  Azure SQL Studio
-  Power BI
-  Excel
<br/><br/>

### Data Preparation
During the first stage of data preparation, I completed the following tasks:
1.  Data Inspection
2.  Handling Missing Values
3.  Data Formatting
<br/><br/>

### Exploratory Data Analysis (EDA)
Exploratory analysis sought to answer the following questions:
1. What is the general trend in sales?
2. Which product or products are the best-selling and most profitable?
3. When are sales at their peak?

### Analysis Methods
Bulk insert was used to get into data Azure Studio, the following are a few intriguing code snippets:
~~~ SQL
--Inserting data into the table
BULK INSERT Sales_Data
FROM 'C:\Users\camuh\Desktop\Datasets For Analysis\salesdata.csv'
WITH (FORMAT = 'CSV');

~~~










