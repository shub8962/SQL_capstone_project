use sample_superstore;

-- Data is a collection of usefull information, that contains numbers,string,binary are collected through observation--- 

-- primary key = cust_id, prod_id --
-- foreign key = cust_id, order_id, ship_id--

select * from cust_dimen a;
select * from market_fact b;
select * from orders_dimen c;
select * from prod_dimen d;
select * from shipping_dimen e;

-- Q1. Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen.
select customer_name as 'Customer Name' ,customer_segment as 'Customer Segment' from cust_dimen;

-- Q2. Write a query to find all the details of the customer from the table cust_dimen order by desc.
select * from cust_dimen order by customer_name desc;

-- Q3. Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.
select order_id,order_date from orders_dimen where order_priority = 'high' ;

-- Q4. Find the total and the average sales (display total_sales and avg_sales) 
select sum(sales) 'total_sales', avg(sales) 'avg_sales' from market_fact;

-- Q5. Write a query to get the maximum and minimum sales from maket_fact table.
select max(sales) as maximam_sales,  min(sales) as minimum_sales from market_fact;

-- Q6. Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers.
select region, count(customer_name) 'no of customers' from cust_dimen group by region order by count(customer_name) desc ;

-- Q7. Find the region having maximum customers (display the region name and max(no_of_customers)
select region, count(customer_name) 'customer' from cust_dimen group by region order by count(customer_name) desc limit 1 ;

-- Q8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased)
select customer_name, region,count(customer_name) 'number of table purchased' from cust_dimen a 
join market_fact b on a.cust_id=b.cust_id 
join prod_dimen d on b.prod_id=d.prod_id 
where a.region= 'atlantic' and d.product_sub_category = 'tables' 
group by customer_name order by customer_name; 
select Customer_Name, count(*) as num_tables from market_fact s,cust_dimen c, prod_dimen p     
where s.Cust_id = c.Cust_id and s.Prod_id = p.Prod_id and p.Product_Sub_Category = 'TABLES' and c.Region = 'ATLANTIC'   
group by Customer_Name;

-- Q9. Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners)
select customer_name, count(*) 'no of small business owner' from cust_dimen where customer_segment = 'small business' and province= 'ontario' group by customer_name; 

-- Q10. Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold) 
select prod_id, count(order_quantity) as 'no of product sold' from market_fact group by prod_id order by count(order_quantity) desc;

-- Q11. Display product Id and product sub category whose produt category belongs to Furniture and Technlogy. The result should contain columns product id, product sub category.
select prod_id,product_Sub_Category from prod_dimen where product_Category = 'FURNITURE' or Product_Category = 'technology';

-- Q12. Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?
select b.product_category, a.profit from market_fact as a inner join  prod_dimen as b on a.prod_id=b.prod_id group by product_category order by profit desc;
select Product_Category,Profit from market_fact s,prod_dimen p where s.Prod_id = p.Prod_id
group by Product_Category order by Profit desc;

-- Q13. Display the product category, product sub-category and the profit within each subcategory in three columns. 
select a.product_category,a.product_sub_category,b.profit from prod_dimen a,market_fact b where a.prod_id=b.prod_id group by product_sub_category;

-- Q14. Display the order date, order quantity and the sales for the order.
select o.order_date,m.order_quantity,m.sales from orders_dimen o,market_fact m where o.ord_id=m.ord_id;

/* Q15. Display the names of the customers whose name contains the 
 i) Second letter as ‘R’
 ii) Fourth letter as ‘D’ */
 select customer_name from cust_dimen where customer_name like '_R%' and customer_name like '___D%';
 
-- Q16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000.
select b.cust_id,a.sales,b.customer_name,b.region from market_fact A,cust_dimen B where a.cust_id=b.cust_id and sales between 1000 and 5000;

-- Q17. Write a SQL query to find the 3rd highest sales.
select min(Sales) as `3rd highest sales` FROM (select Sales from market_fact order by Sales desc limit 3) as a; -- alias is must here--
select sales as '3rd highest sales' from(select sales from market_fact order by sales desc limit 3) as a order by sales asc limit 1; -- another way to run this query--
select top 1 sales as '3rd highest sales' from (select top 3 sales from market_id order by salary desc) as a order by sales asc;    -- another way to run this query--
 
/*Q18. Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, display the region-wise no_of_shipments and the 
profit made in each region in decreasing order of profits (i.e. region,no_of_shipments, profit_in_each_region)*/
select region,count(ship_id) 'as number of shipment',sum(profit) 'as profit in each region' from market_fact a,cust_dimen b,prod_dimen c where a.cust_id=b.cust_id and a.prod_id=c.prod_id 
group by region order by sum(profit) desc;

 -- Note: You can hardcode the name of the least profitable product subcategory--