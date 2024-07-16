/************************************************************============ Wallmart Database =========== *******************************************************************
 -- Database created by: Kotla Suresh
 -- Database Name: electoralbonddata
 -- Author of Queries : Kotla Suresh
 -- Organization : Careerpedia
 -- Date : 18-April-2024


create database wallmart;
use wallmart;
show tables;
select * from sk;

-- BusinessQuestions To Answer  
-- GenericQuestion

-- 1. How many unique cities does the data have?
select  distinct City from sk;

-- 2. In which city is each branch?
select   Branch , City from sk;

-- Product
-- 1. How many unique product lines does the data have?
select distinct Product_line from sk;

ALTER TABLE sk
CHANGE `Product line` Product_line text;
ALTER TABLE sk
CHANGE `Tax 5%` WAT DOUBLE;
ALTER TABLE sk
CHANGE `Unit price` Unit_price DOUBLE;
ALTER TABLE sk
CHANGE `gross margin percentage` Gross_margin_percentage DOUBLE;
alter table sk
change `Customer type` customer_type text;

-- 2. What is the most common payment method?
select distinct payment from sk;

-- 3. What is the most selling product line?
 select product_line,SUM(quantity) as most_selling
 from sk
 group by product_line
 ORDER BY most_selling DESC;
 
 alter table sk
 add column month_name  varchar(50) not null;
 alter table sk
 add column day_name varchar(50) not null;
 alter table sk
 add column time_of_day varchar(50) not null;
 
 update sk 
 set time_of_day = case
					 when hour(Time) < 12 then 'morning'
                     when hour(Time) < 18 then 'afternoon'
					 else 'evening'
				   end;

UPDATE sk
SET day_name = DAYNAME(STR_TO_DATE(Date, '%m/%d/%Y'));
UPDATE sk
SET month_name = MONTHNAME(STR_TO_DATE(Date, '%m/%d/%Y'));

 
-- 4. What is the total revenue by month?
select month_name,sum(Total) as tt from sk
group by month_name
order by  tt desc;

-- 5. What month had the largest COGS?
select month_name,max(cogs) as kk from sk
group by month_name
order by kk desc;

-- 6. What product line had the largest revenue?
select product_line, max(Total) as pt from sk
group by product_line
order by pt desc;

-- 7. What is the city with the largest revenue?
select city, max(Total) as mt from sk
group by city
order by mt desc;

-- 8. What product line had the largest VAT?
select product_line,max(WAT) as hh from sk
group by product_line
order by hh desc;

-- 9. Fetch each product line and add a column to those product line showing "Good","Bad". Good if its greater than average sales
select product_line,sum(Total) as jj,
case  
	when sum(total) > avg(total) then "Good"
    else "bad" 
    end "type"
    from sk
group by product_line
order by jj desc;


-- 10. Which branch sold more products than average product sold?
 select Branch , sum(Quantity) as pp from sk
group by Branch
having SUM(Quantity) > (select avg(total) from sk);

-- 11. What is the most common product line by gender?
select Gender,product_line, count(*) as pp from sk
group by Gender,product_line
order by pp desc;

-- 12. What is the average rating of each product line?
select product_line, avg(Rating) as mm from sk
group by  product_line
order by mm desc;

-- Sales

-- 1. Number of sales made in each time of the day per weekday
select day_name,time_of_day , count(*) as ti_me from sk
group by  day_name,time_of_day
order by ti_me desc;

-- 2. Which of the customer types brings the most revenue?
select Customer_type, sum(Total) as bb from sk
group by Customer_type
order by bb desc;

-- 3. Which city has the largest tax percent/ VAT (Value Added Tax)?
select City,max(WAT) as VAT from sk
group by City
order by VAT desc;

-- 4. Which customer type pays the most in VAT?
select customer_type,max(WAT) as VAT from sk
group by customer_type
order by VAT desc;

-- Customer

-- 1. How many unique customer types does the data have?
select distinct customer_type from sk;

-- 2. How many unique payment methods does the data have?
select distinct payment from sk;

-- 3. What is the most common customer type?
select distinct customer_type from sk;

-- 4. Which customer type buys the most?
select customer_type , max(Quantity) as gg from sk
group by customer_type
order by gg desc;

-- 5. What is the gender of most of the customers?
select max(gender) from sk;

-- 6. What is the gender distribution per branch?
select count(Gender),(branch) as ff from sk
group by branch;

-- 7. Which time of the day do customers give most ratings?
select Rating,max(time_of_day) as ss from sk
group by rating
order by ss desc;

-- 8. Which time of the day do customers give most ratings per branch?

select Branch,max(time_of_day) as uu from sk
group by branch
order by uu desc;

-- 9. Which day of the week has the best avg ratings?
select day_name,avg(Rating) as rat from sk
group by day_name
order by rat desc;

-- 10. Which day of the week has the best average ratings per branch?
select Branch, day_name, avg(Rating) as ii from sk
group by Branch,day_name
order by ii desc
limit 3;


/*****************************************************************
== My Conclusions after looking into the results of the queries ==
-- Point 1 the above data we adding the extra columns
-- point 2 the update the data set proper way
-- point 3 there is different sections is there 1.GenericQuestion 2.Product 3.Sales 4.Customer 
-- point 4 given the quetions there is the 6 types of product_line are there 
-- point 5 the data caculation of total sales and products to selling 
-- point 6 total revenu of the products its showing up on
-- point 7 the quantity of the items and selling expencess and each one of the product price and showing.
-- point 8 the caculation of total revenu and sales showing up on.
.
****************************************************************/
