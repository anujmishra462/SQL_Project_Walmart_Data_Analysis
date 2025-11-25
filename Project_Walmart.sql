# Walmart Customer Purchase Behaviours Analysis

# DATABASE
create database Walmart_Behaviours;

# USE DATABASE
use Walmart_Behaviours;

# TOTAL CUSTOMERS PURCHASES
select count(*) from walmart_custpurchase;

select * from walmart_custpurchase;


# 1 List all unique cities present in the dataset.
select count(distinct(city)) from walmart_custpurchase;


# 2 Count the total number of purchases.
select count(purchase_date) from walmart_custpurchase;


# 3 Find the minimum, maximum, and average Purchase_Amount overall.
select min(Purchase_Amount) as Minimum, max(Purchase_Amount) as Maximum, 
avg(Purchase_Amount) as Avg_Purchase_Amt
from walmart_custpurchase;


# 4 Show all purchases where Discount_Applied = 'Yes'.
select * from walmart_custpurchase 
where Discount_Applied = "Yes";


# 5 Count how many purchases were made by male vs female customers.
-- Male
select count(*) 
from walmart_custpurchase 
where Gender = "Male";

-- Female
select count(*) 
from walmart_custpurchase 
where Gender = "Female";

select (select count(*) from walmart_custpurchase where Gender = "Male") as Male_Purchased,
(select count(*) from walmart_custpurchase where Gender = "Female") as Female_Purchased 
from walmart_custpurchase limit 1;


#  6 Find the top 5 cities by number of purchases.
select City, count(distinct(customer_id)) as Number_of_Purchases 
from walmart_custpurchase
group by City 
Order by Number_of_Purchases desc limit 5;


# 7 Return the first purchase date and last purchase date in the dataset.
-- First Purchase Date
select Purchase_Date 
from walmart_custpurchase 
Order by Purchase_date Asc;

-- Last Purchase Date
select Purchase_Date 
from walmart_custpurchase 
Order by Purchase_date Desc;

select (select Purchase_Date from walmart_custpurchase Order by Purchase_date Asc limit 1) as First_Purchase_Date,
(select Purchase_Date from walmart_custpurchase Order by Purchase_date Desc limit 1) as Last_Purchase_Date
from walmart_custpurchase Order by Purchase_date Limit 1;


# 8. Find the top 5 cities by total sales.
select City, sum(purchase_amount) from walmart_custpurchase
group by City
Order By  count(City) Desc Limit 5;


# 9. Identify the top 10 product names by total revenue in 2024.
select Product_Name,SUM(Purchase_Amount) 
from walmart_custpurchase
where Purchase_Date = 2024
Group By Product_Name 
Order By SUM(Purchase_Amount) desc Limit 10;


# 10. Find the average purchase amount for customers aged between 25 and 35 (inclusive).
select Age , avg(purchase_amount) as Avg_Purchases
from walmart_custpurchase
where Age between 25 and 35
Group By Age
Order by Age;



# 11. Find products whose average rating < 3 but total sales > 10,000.
select Product_Name, Avg(Rating), sum(purchase_amount) as Total_Sales 
from walmart_custpurchase
Group By Product_Name
Having Avg(Rating)<3
Order By Total_Sales > 10000 desc;

# 12. For each City, compute repeat-customers and rank cities by this rate.
select city, dense_rank() Over(Order By City) as A 
from walmart_custpurchase
where Repeat_Customer = "Yes"
Group By City;

