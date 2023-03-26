-- Create a view that shows the current inventory for every retailer
create view product_inventory_view as
select inventory.RetailerID as RetailerID, product_categories.ProductID as ProductID, product_categories.SubCategoryID as SubCategoryID, product_categories.CategoryID as CategoryID, inventory.QuantityRemaining as QuantityRemaining
from inventory, batches, product_categories
where (batches.BatchID = inventory.BatchID) and (batches.ProductID = product_categories.ProductID);

-- Create a stored procedure to sell a product from a retailer
DELIMITER $$
create procedure sell_product(IN RID varchar(36), IN PID varchar(36), IN QTY int)
begin
    declare BID varchar(36);
    declare QTYR int;
    declare done tinyint default FALSE;
    declare cur cursor for select inventory.BatchID, inventory.QuantityRemaining from inventory, batches where(inventory.BatchID = batches.BatchID) order by batches.ManufactureDate;
    declare continue handler for not found set done = TRUE;
    open cur;
    read_loop: loop
        fetch next from cur into BID, QTYR;
        if done then
            leave read_loop;
        end if;
        if (QTYR >= QTY) then
            update inventory set QuantityRemaining = QuantityRemaining - QTY where BatchID = BID;
            leave read_loop;
        else
            update inventory set QuantityRemaining = 0 where BatchID = BID;
            set QTY = QTY - QTYR;
        end if;
    end loop;
end $$
DELIMITER ;


-- Get the current inventory for every retailer
select 
    if(grouping(retailers.Name), 'All Retailers', retailers.Name) as Retailer,
    if(grouping(categories.Name), 'All Categories', categories.Name) as Category,
    if(grouping(subcategories.Name), 'All SubCategories', subcategories.Name) as SubCategory,
    if(grouping(products.Name), 'All Products', products.Name) as Product,
    sum(QuantityRemaining) as QuantityRemaining
from product_inventory_view
join retailers on retailers.RetailerID = product_inventory_view.RetailerID
join categories on categories.CategoryID = product_inventory_view.CategoryID
join subcategories on subcategories.SubCategoryID = product_inventory_view.SubCategoryID
join products on products.ProductID = product_inventory_view.ProductID
group by categories.Name, subcategories.Name, products.Name, retailers.Name with rollup;

-- Get the history of all supply orders item wise for a supplier (e7a0899e-bd54-4302-aba0-a71041c13592)
select
    if(grouping(categories.Name), 'All Categories', categories.Name) as Category,
    if(grouping(subcategories.Name), 'All SubCategories', subcategories.Name) as SubCategory,
    if(grouping(products.Name), 'All Products', products.Name) as Product,
    sum(Quantity) as Quantity
from batches
join product_categories on product_categories.ProductID = batches.ProductID
join categories on categories.CategoryID = product_categories.CategoryID
join subcategories on subcategories.SubCategoryID = product_categories.SubCategoryID
join products on products.ProductID = product_categories.ProductID
where batches.SupplierID = "e7a0899e-bd54-4302-aba0-a71041c13592"
group by categories.Name, subcategories.Name, products.Name with rollup;

-- Get the average rating of all products, subcategories, and categories
select
    if(grouping(categories.Name), 'All Categories', categories.Name) as Category,
    if(grouping(subcategories.Name), 'All SubCategories', subcategories.Name) as SubCategory,
    if(grouping(products.Name), 'All Products', products.Name) as Product,
    avg(products.Rating) as AverageRating
from products
join product_categories on product_categories.ProductID = products.ProductID
join categories on categories.CategoryID = product_categories.CategoryID
join subcategories on subcategories.SubCategoryID = product_categories.SubCategoryID
group by categories.Name, subcategories.Name, products.Name with rollup;

-- Get the sales of all products, subcategories, and categories for every retailer
select
    if(grouping(retailers.Name), 'All Retailers', retailers.Name) as Retailer,
    if(grouping(categories.Name), 'All Categories', categories.Name) as Category,
    if(grouping(subcategories.Name), 'All SubCategories', subcategories.Name) as SubCategory,
    if(grouping(products.Name), 'All Products', products.Name) as Product,
    sum(product_order_items.Quantity) as Quantity,
    round(sum(product_order_items.Amount), 2) as Amount
from product_order_items
join retailers on retailers.RetailerID = product_order_items.RetailerID
join product_categories on product_categories.ProductID = product_order_items.ProductID
join categories on categories.CategoryID = product_categories.CategoryID
join subcategories on subcategories.SubCategoryID = product_categories.SubCategoryID
join products on products.ProductID = product_categories.ProductID
group by categories.Name, subcategories.Name, products.Name, retailers.Name with rollup;

-- Get the current stock w.r.t items, brands and ratings
select
    if(grouping(products.Rating), 'All Ratings', products.Rating) as Rating,
    if(grouping(brands.Name), 'All Brands', brands.Name) as Brand,
    if(grouping(products.Name), 'All Products', products.Name) as Product,
    sum(product_inventory_view.QuantityRemaining) as QuantityRemaining
from product_inventory_view
join products on products.ProductID = product_inventory_view.ProductID
join brands on brands.BrandID = products.BrandID
group by cube(products.Rating, brands.Name, products.Name);


-- Create a trigger to reduce the inventory after delivering the order
DELIMITER $$
create trigger reduce_inventory
after update on product_orders
for each row
begin
    declare RID varchar(36);
    declare PID varchar(36);
    declare QTY int;
    declare done tinyint default FALSE;
    declare cur cursor for select RetailerID, ProductID, Quantity from product_order_items where product_order_items.OrderID = new.OrderID;
    declare continue handler for not found set done = TRUE;
    if (new.Status = "Delivered") then
        open cur;
        read_loop: loop
            fetch cur into RID, PID, QTY;
            if done then
                leave read_loop;
            end if;
            call sell_product(RID, PID, QTY);
        end loop;
        close cur;
    end if;
end $$
DELIMITER ;

-- Create a trigger to remove a batch from inventory if QuantityRemaining is 0
DELIMITER $$
create trigger remove_batch
after update on inventory
for each row
begin
    if (new.QuantityRemaining = 0) then
        delete from inventory where BatchID = new.BatchID;
    end if;
end $$
DELIMITER ;

-- Create a trigger to increase the inventory after receiving the supply order
DELIMITER $$
create trigger increase_inventory
after update on supply_orders
for each row
begin
    if (new.Status = "Delivered") then
        insert into inventory (RetailerID, BatchID, QuantityRemaining)
        select batches.RetailerID, batches.BatchID, batches.Quantity
        from batches
        where (batches.BatchID = order_batches.BatchID) and (order_batches.OrderID = new.OrderID);
    end if;
end$$
DELIMITER ;