import os
from fastapi import APIRouter
import mysql.connector as mysql

deadlinerouter = APIRouter(prefix="/api/deadline")

@deadlinerouter.get("/OLAP1")
def OLAP1():
    """Return the current inventory for all the retailers"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("""  
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
    """)
    result = cursor.fetchall()
    data = [{
        "Retailer" : row[0],
        "Category" : row[1],
        "SubCategory" : row[2],
        "Product" : row[3],
        "QuantityRemaining" : row[4]
    } for row in result]
    return {
        "status" : "success",
        "data" : data
    }

@deadlinerouter.get("/OLAP2/{supplier_id}")
def OLAP2(supplier_id:str):
    """Get the history of all products supplied by a supplier"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )       
    cursor = db.cursor()
    cursor.execute(f"""
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
        where batches.SupplierID = '{supplier_id}'
        group by categories.Name, subcategories.Name, products.Name with rollup;
    """)
    result = cursor.fetchall()
    data = [{
        "Category" : row[0],
        "SubCategory" : row[1],
        "Product" : row[2],
        "Quantity" : row[3]
    } for row in result]
    return {
        "status" : "success",
        "data" : data
    }

@deadlinerouter.get("/OLAP3")
def OLAP3():
    """Get the average rating of all the products"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )   
    cursor = db.cursor()
    cursor.execute("""
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
    """)
    result = cursor.fetchall()
    data = [{
        "Category" : row[0],
        "SubCategory" : row[1],
        "Product" : row[2],
        "AverageRating" : row[3]
    } for row in result]
    return {
        "status" : "success",
        "data" : data
    }

@deadlinerouter.get("/OLAP4")
def OLAP4():
    """Get the sales of all the products by all the retailers"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("""
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
    """)
    result = cursor.fetchall()
    data = [{
        "Retailer" : row[0],
        "Category" : row[1],
        "SubCategory" : row[2],
        "Product" : row[3],
        "Quantity" : row[4],
        "Amount" : row[5]
    } for row in result]
    return {
        "status" : "success",
        "data" : data
    }

@deadlinerouter.get("/EmbeddedSQL1")
def EmbeddedSQL1():
    """Get the number of orders placed by each customer"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("""
        select customers.CustomerID, customers.Name, count(*) as "Number of Orders" 
        from customers 
        inner join product_orders on customers.CustomerID = product_orders.CustomerID 
        group by customers.CustomerID 
        order by count(*) desc;
    """)
    result = cursor.fetchall()
    data = [{
        "CustomerID" : row[0],
        "Name" : row[1],
        "Number of Orders" : row[2]
    } for row in result]
    return {
        "status" : "success",
        "data" : data
    }

@deadlinerouter.get("/EmbeddedSQL2")
def EmbeddedSQL2():
    """Get the pending orders of each retailer"""
    db = mysql.connect(
        host = "lin-16287-9495-mysql-primary.servers.linodedb.net",
        user = os.environ['MySQL_USER'],
        passwd = os.environ['MySQL_PASSWORD'],
        database = "DrugVeda"
    )
    cursor = db.cursor()
    cursor.execute("""
        select retailers.Name, count(*) as "Number of Pending Orders"
        from product_orders, product_order_items, retailers
        where (product_orders.Status = "Placed") and (product_order_items.RetailerID = retailers.RetailerID) and (product_orders.OrderID = product_order_items.OrderID)
        group by product_order_items.RetailerID;
        order by count(*) desc;
    """)
    result = cursor.fetchall()
    data = [{
        "Retailer" : row[0],
        "Number of Pending Orders" : row[1]
    } for row in result]
    return {
        "status" : "success",
        "data" : data
    }
