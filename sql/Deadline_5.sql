-- Create a view that shows the current inventory for every retailer
create view product_inventory_view as
select inventory.RetailerID as RetailerID, product_categories.ProductID as ProductID, product_categories.SubCategoryID as SubCategoryID, product_categories.CategoryID as CategoryID, inventory.QuantityRemaining as QuantityRemaining
from inventory, batches, product_categories
where (batches.BatchID = inventory.BatchID) and (batches.ProductID = product_categories.ProductID);


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

