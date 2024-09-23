
SELECT 
    *
FROM
    olistpayments;
    
 desc olistitems;
 
SELECT 
    *
FROM
    olistorders;
    
 SELECT 
    Order_Purchase_timestamp
FROM
    Olistorders; 
 
 # WeekDay VS Weekend Sales
 SELECT 
    CASE
        WHEN WEEKDAY(order_purchase_timestamp) IN (0 , 1, 2, 3, 4) THEN 'weekday'
        ELSE 'weekend'
    END AS day_of_week,
    ROUND(SUM(payment_value), 0) AS Total_value,
    CONCAT(ROUND(SUM(payment_value) / (SELECT 
                            SUM(payment_value)
                        FROM
                            olistorders) * 100,
                    2),
            '%') AS Total_value_in_percent
FROM
    olistorders AS ord
        JOIN
    olistpayments AS pay ON ord.order_id = pay.order_id
GROUP BY 1;
      
      
# Total Orders Where Payment Type Is "Credit Card" And Review Rating Is 5
SELECT 
    *
FROM
    OlistRatings;
    
SELECT 
    *
FROM
    olistpayments;
    
SELECT 
    COUNT(pay.ORDER_ID) AS Total_count
FROM
    olistpayments AS rev
        JOIN
    olistRatings AS pay ON pay.order_id = rev.order_id
WHERE
    review_score = 5
        AND payment_type = 'credit_card';
      
	
# Shipping Days Taken When Order Is Placed For Pet Shop Itemss?

SELECT 
    *
FROM
    olist_orders_dataset;

SELECT 
    ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                    order_purchase_timestamp)),
            0) AS avg_day
FROM
    olistorders AS ord
        JOIN
    olistitems AS oli ON ord.order_id = oli.order_id
        JOIN
    olistproducts AS pr ON oli.product_id = pr.product_id
WHERE
    product_category_name = 'pet_shop';
      
# Pricing Stats For Sao Paulo City

use excelrprojects;

SELECT 
    *
FROM
    olistcustomers;

SELECT 
    *
FROM
    olistorders;
    
with cte as
	(select round(avg(price),0) as avg_item_price 
	from olist_order_items_dataset as item join
	olist_orders_dataset as ord
	on item.order_id=ord.order_id 
 join olist_customers_dataset as cust
on cust.customer_id=ord.customer_id where customer_city="sao paulo")
      select (select avg_item_price from cte) as avg_item_price, 
      round(avg(payment_value),0) as avg_payment from olist_order_payments_dataset as pay join
 olist_orders_dataset as ord
on pay.order_id=ord.order_id 
 join olist_customers_dataset as cust
on cust.customer_id=ord.customer_id where customer_city="sao paulo";

      
# Shipping Days To Review Score 

SELECT 
    review_score,
    ROUND(AVG(DATEDIFF(order_delivered_customer_date,
                    order_purchase_timestamp)),
            0) AS avg_days_reqd_for_delivery
FROM
    olistorders AS ord
        JOIN
    olistorderratings AS rev ON ord.order_id = rev.order_id
GROUP BY 1
ORDER BY 1 ASC;
    
