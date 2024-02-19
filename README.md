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


SELECT SUM(price) AS Price ,SUM(qty_ordered) AS Qty 
,ROUND(SUM(price * qty_ordered),2)  AS Cost, 
ROUND(SUM(sales),2) AS sales ,SUM(sales) - SUM(qty_ordered) AS Profit ,b.city 
FROM 
(SELECT
	order_date
	,sales
	,price
	,qty_ordered
	,product_line
	,status_now
FROM Sales_Data) a
LEFT JOIN
(SELECT
	order_date
	,contact_fname
	,customer_name
	,address_line1
	,city
FROM Sales_Data) b
ON a.order_date = b.order_date

GROUP BY b.city;

~~~
Microsoft Power BI was used extensively in this project, demonstrating the beneficial application of business intelligence in project work.
<br/><br/>

### Result & Findings
The analysis's outcome revealed the following:
- Every year in the fourth quarter, the store made more sales than during the first two years of its existence.
- Despite being the best-selling product category, classic cars lost money in the two territories.
- All year long, planes and ships suffered total losses.


<br/><br/>
### Visuals

![Sales by month 3](https://github.com/bravechristian/E-Commerce-Sales-Analysis/assets/113802347/c1968bf7-6c04-41d0-a9f9-74c8d336bc5c)

![Sales by month](https://github.com/bravechristian/E-Commerce-Sales-Analysis/assets/113802347/e933a8c6-b73f-4855-9b28-603116b1e2bd)

![Sales Quarter](https://github.com/bravechristian/E-Commerce-Sales-Analysis/assets/113802347/75512f44-c64f-499c-b8d5-9104e9e8e45e)

![sum3](https://github.com/bravechristian/E-Commerce-Sales-Analysis/assets/113802347/c4c77e90-bd85-4904-8064-d9b63e3d3af3)

<br/><br/>
### Recommendations
- The organizations should consider factors that impede the sales of ships and planes, perhaps the price point should be reviewed and a new strategy devised for the marketing of these products.
- Since sales are periodic, it will be in place if research is funded into why that is the way it is, supposing we could identify the reason for the periodic sales, a strategy could be developed to help push and encourage sales all through the four quarters.
- It seems like the product Classic Cars is in very high demand across all seasons, this could mean a couple of things one being that the product is excellent, and as such it should extended across a lot more regions, this will increase the overall revenue of the business.

<br/><br/>

### Limitations
- During the cleaning phase of the data processing, null values were substituted for 0, this could impart the overall result of this analysis
- The bulk insert command in SQL, some data could have been dropped due to data type compartibility issues, this could also have an impart on this analysis.











