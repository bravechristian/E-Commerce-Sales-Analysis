USE hrDatasets;

--Creating table
IF OBJECT_ID('Sales_Data') IS NOT NULL DROP TABLE Sales_Data

CREATE TABLE Sales_Data (
	Order_number BIGINT
	,qty_ordered INT
	,price FLOAT
	,order_line_no INT
	,sales FLOAT
	,order_date DATETIME
	,status_now VARCHAR(50)
	,qty_id INT
	,month_id INT
	,year_id INT
	,product_line VARCHAR(255)
	,MSRP INT
	,product_code NVARCHAR(200)
	,customer_name VARCHAR(255)
	,phone_number NVARCHAR(200)
	,address_line1 NVARCHAR(1000)
	,address_line2 NVARCHAR(1000)
	,city VARCHAR(255)
	,state_id VARCHAR(50)
	,postalcode NVARCHAR(500)
	,country VARCHAR(255)
	,territory VARCHAR(255)
	,contact_lname VARCHAR(255)
	,contact_fname VARCHAR(255)
	,deal_size VARCHAR(50)
);


--Inserting data into the table
BULK INSERT Sales_Data
FROM 'C:\Users\camuh\Desktop\Datasets For Analysis\salesdata.csv'
WITH (FORMAT = 'CSV');



SELECT * FROM Sales_Data;

SELECT SUM(sales) AS total_sales
FROM Sales_Data;


--Showing parameters of interest

SELECT 
	 sales
	,qty_ordered
	,country
	,year_id
FROM Sales_Data ORDER BY 4;


--Showing results for the country with the highest total amount in sales

SELECT 
	 SUM(sales) AS total_sales
	,SUM(qty_ordered) AS total_quantity
	,country
FROM Sales_Data GROUP BY country
ORDER BY 1 DESC;

--Creating view for visualization in Power BI for country with the highest total amount in sales

--DROP VIEW hihest_sales;

CREATE VIEW 
highest_sales AS
(SELECT 
	 SUM(sales) AS total_sales
	,SUM(qty_ordered) AS total_quantity
	,country
FROM Sales_Data GROUP BY country);

--SELECT * FROM highest_sales;


--Showing results for the year with the highest sales figures

SELECT 
	 SUM(sales) AS total_sales
	,SUM(qty_ordered) AS total_quantity
	,year_id
FROM Sales_Data GROUP BY year_id
ORDER BY 3;


--Creating view for highest sales figures per year

CREATE VIEW sales_per_year AS
SELECT 
	 SUM(sales) AS total_sales
	,SUM(qty_ordered) AS total_quantity
	,year_id
FROM Sales_Data GROUP BY year_id;

--SELECT * FROM sales_per_year;


--Showing results for the total cost of sales

SELECT 
	 SUM(sales) AS total_sales
	,SUM(price) AS price_amount
	,SUM(qty_ordered) AS total_quantity
	,SUM(price * qty_ordered) AS cost
	,country
FROM Sales_Data GROUP BY country
ORDER BY 1 DESC;

--Showing results for the profits gained per country

SELECT 
	 country
	,SUM(sales) AS total_sales
	,SUM(price) AS price_amount
	,SUM(qty_ordered) AS total_quantity
	,SUM(price * qty_ordered) AS cost
	,SUM(sales - (price * qty_ordered)) AS Profit
FROM Sales_Data GROUP BY country
ORDER BY 6 DESC;


--Creating view for profits per country

CREATE VIEW profit_country AS
(SELECT 
	 country
	,SUM(sales) AS total_sales
	,SUM(price) AS price_amount
	,SUM(qty_ordered) AS total_quantity
	,SUM(price * qty_ordered) AS cost
	,SUM(sales - (price * qty_ordered)) AS Profit
FROM Sales_Data GROUP BY country);

SELECT * FROM profit_country;




--Showing results for the year with the highest profit

SELECT 
	 year_id
	,SUM(sales) AS total_sales
	,SUM(price * qty_ordered) AS Cost
	,SUM(sales - (price * qty_ordered)) AS Profit
FROM Sales_Data GROUP BY year_id
ORDER BY 1;

--SELECT * FROM	Sales_Data;


--Creating view for the with the highest profit

CREATE VIEW highest_year_profit AS

SELECT 
	 year_id
	,SUM(sales) AS total_sales
	,SUM(price * qty_ordered) AS Cost
	,SUM(sales - (price * qty_ordered)) AS Profit
FROM Sales_Data GROUP BY year_id;

SELECT * FROM highest_year_profit;


--Showing results for goods yet to be shipped and customer details

SELECT 
	 status_now
	 ,qty_ordered
	 ,product_line
	 ,customer_name
	 ,phone_number
	 ,address_line1
	 ,city
	 ,contact_fname
FROM Sales_Data WHERE status_now <> 'Shipped';



--Showing results for one customer alone so the team can follow up and resolve every proble they may have

SELECT 
	  status_now
	 ,qty_ordered
	 ,product_line
	 ,customer_name
	 ,phone_number
	 ,address_line1
	 ,city
	 ,contact_fname
FROM Sales_Data 
WHERE customer_name = 'Euro Shopping Channel' AND status_now <> 'Shipped';



SELECT * FROM Sales_Data;

--Showing results for customers in the USA whose goods are to be shipped

SELECT 
	  status_now
	 ,qty_ordered
	 ,product_line
	 ,customer_name
	 ,phone_number
	 ,address_line1
	 ,contact_fname
	 ,country
FROM Sales_Data 
WHERE country = 'USA' AND status_now <> 'Shipped';


--Creating joins

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


--Creating more view

--DROP VIEW profitSales

CREATE VIEW profitSales 
AS
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

SELECT * FROM	profitSales;



--Creating a stored procedure

CREATE PROCEDURE spSalesdata  AS

IF OBJECT_ID('Sales_Data') IS NOT NULL DROP TABLE Sales_Data

CREATE TABLE Sales_Data (
	Order_number BIGINT
	,qty_ordered INT
	,price FLOAT
	,order_line_no INT
	,sales FLOAT
	,order_date DATETIME
	,status_now VARCHAR(50)
	,qty_id INT
	,month_id INT
	,year_id INT
	,product_line VARCHAR(255)
	,MSRP INT
	,product_code NVARCHAR(200)
	,customer_name VARCHAR(255)
	,phone_number NVARCHAR(200)
	,address_line1 NVARCHAR(1000)
	,address_line2 NVARCHAR(1000)
	,city VARCHAR(255)
	,state_id VARCHAR(50)
	,postalcode NVARCHAR(500)
	,country VARCHAR(255)
	,territory VARCHAR(255)
	,contact_lname VARCHAR(255)
	,contact_fname VARCHAR(255)
	,deal_size VARCHAR(50)
);


--Inserting data into the table
BULK INSERT Sales_Data
FROM 'C:\Users\camuh\Desktop\Datasets For Analysis\salesdata.csv'
WITH (FORMAT = 'CSV');

EXEC spSalesdata;