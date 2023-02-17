-- Show the number of orders for each customer, sorted by the number of orders in descending order.
select customers.CustomerID, customers.Name, count(*) as "Number of Orders" 
from customers 
inner join product_orders on customers.CustomerID = product_orders.CustomerID 
group by customers.CustomerID 
order by count(*) desc;

-- Show the order history for retailer "22dafbe5-0e3f-4963-8b1d-d82a32f53f2c".
select * 
from supply_orders
where OrderID in (
    select OrderID
    from order_batches
    inner join batches on batches.RetailerID = "22dafbe5-0e3f-4963-8b1d-d82a32f53f2c"
    where batches.BatchID = order_batches.BatchID
);

-- Add a new product with ID "1234-abcd" and name "Test Product"
insert into products (ProductID, Name, Image, Description, Price, BrandID, Rating, RatingCnt, TimeToExpire)
values ("1234-abcd", "Test Product", "Image not Available", "Product Added for testing", 500, "d9f81158fc284176ba190987c5c0e102", 0, 0, "2023-03-03 21:46:02");

insert into product_categories (ProductID, CategoryID, SubCategoryID)
values ("1234-abcd", "4b50594e32fc4231b0e3cc6e0c1480eb", "351853a9a6fa4e0d97b05b29492517b8");

-- Delete an existing product with ID "1234-abcd"
delete from products
where ProductID = "1234-abcd";

-- Show the current inventory for retailer "57f17790-0f63-456d-a7ab-b19a5dbe5a42"
select batches.BatchID, batches.ProductID, products.Name, inventory.QuantityRemaining
from inventory, batches, products
where (inventory.RetailerID = "57f17790-0f63-456d-a7ab-b19a5dbe5a42") and (batches.BatchID = inventory.BatchID) and (batches.ProductID = products.ProductID);

-- Complete an Order with ID "46cfbccbaea211eda143f889d2839e9e".
update product_orders
set Status = "Delivered"
where OrderID = "46cfbccbaea211eda143f889d2839e9e";

-- update inventory 
-- set QuantityRemaining -= 
-- where(

-- )

-- select product_order_items.RetailerID, product_order_items.ProductID, product_order_items.Quantity
-- from product_order_items
-- where OrderID = "46cfbccbaea211eda143f889d2839e9e";

-- Check number of pending orders for every retailer. 
select retailers.Name, count(*) as "Number of Pending Orders"
from product_orders, product_order_items, retailers
where (product_orders.Status = "Placed") and (product_order_items.RetailerID = retailers.RetailerID) and (product_orders.OrderID = product_order_items.OrderID)
group by product_order_items.RetailerID;
order by count(*) desc;

-- Check appointments scheduled between "2023-03-07" and "2023-03-15".
select tests.Name, customers.Name, medical_labs.Name, appointments.AppointmentDate
from appointments
right join tests on tests.TestID = appointments.TestID
right join medical_labs on medical_labs.LabID = tests.LabID
right join customers on customers.CustomerID = appointments.CustomerID
where (DATE(appointments.AppointmentDate) between '2023-03-07' and '2023-03-15')
order by appointments.AppointmentDate;

-- Update the status of appointment as complete.
update appointments
set Result = "Completed"
where AppointmentID = "46d27b3eaea211ed879af889d2839e9e";

-- The total expenditure of all customers between "2023-03-07" and "2023-03-15".
select customers.Name, sum(product_orders.Amount)
from product_orders
inner join customers on product_orders.CustomerID = customers.CustomerID
where (DATE(product_orders.OrderDate) between '2023-03-07' and '2023-03-15')
group by customers.CustomerID;
