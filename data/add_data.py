import mysql.connector as sql
from json import load
import typing
import random
import uuid
from datetime import datetime, timedelta

db:sql.connect = None
cursor:sql.cursor = None

#  Dictionary of brands and their ids
brands:dict[str, str] = {}

def random_date(days:int) -> str:
    """Generates random date from now to now + timedelta
    timedelta is in days"""
    start = datetime.now()
    end = start + timedelta(days=days)
    random_date = start + (end - start) * random.random()

    return str(random_date.replace(microsecond=0))

def add_data_customers()->None:
    """Add data to customers table"""
    json_file = open("data/json/users.json", "r")
    json_data = load(json_file)
    for user in json_data:
        cursor.execute("INSERT INTO customers (CustomerID, Name, Email, Phone, Lat, Lon) VALUES ('{}', '{}', '{}', '{}', {}, {})".format(user['user_id'], user['name'], user['email'], user['phone'], user['latitude'], user['longitude']))
    db.commit()
    json_file.close()

def add_data_retailers()->None:
    """Add data to retailers table"""
    json_file = open("data/json/retailers.json", "r")
    json_data = load(json_file)
    for retailer in json_data:
        cursor.execute("INSERT INTO retailers (RetailerID, Name, Email, Phone, Lat, Lon, Managaer) VALUES ('{}', '{}', '{}', '{}', {}, {}, '{}')".format(retailer['retailer_id'], retailer['name'], retailer['email'], retailer['phone'], retailer['latitude'], retailer['longitude'], retailer['manager_name']))
    db.commit()
    json_file.close()

def add_data_suppliers()->None:
    """Add data to suppliers table"""
    json_file = open("data/json/supplier.json", "r")
    json_data = load(json_file)
    for supplier in json_data:
        cursor.execute("INSERT INTO suppliers (SupplierID, Name, Email, Phone, Lat, Lon) VALUES ('{}', '{}', '{}', '{}', {}, {})".format(supplier['user_id'], supplier['name'], supplier['email'], supplier['phone'], supplier['latitude'], supplier['longitude']))
    db.commit()
    json_file.close()

def add_data_labs()->None:
    """Add data to labs table"""
    json_file = open("data/json/labs.json", "r")
    json_data = load(json_file)
    for lab in json_data:
        cursor.execute("INSERT INTO medical_labs (LabID, Name, Email, Phone, Lat, Lon) VALUES ('{}', '{}', '{}', '{}', {}, {})".format(lab['user_id'], lab['name'], lab['email'], lab['phone'], lab['latitude'], lab['longitude']))
    db.commit()
    json_file.close()

def get_brand_id(brand_name:str)->str:
    """Get brand id from brand name, adds brand to brands table if not present"""
    global brands
    if brand_name in brands:
        return brands[brand_name]
    else:
        brand_id:str = str(uuid.uuid4().hex)
        brands[brand_name] = brand_id
        cursor.execute("INSERT INTO brands (BrandID, Name, Email) VALUES ('{}', '{}', '{}')".format(brand_id, brand_name, random.choice(['help', 'support', 'contact']) + '@' + brand_name + '.com'))
        return brand_id

def add_data_products()->None:
    """Add data to products, categories and subcategories tables"""
    json_file = open("data/json/products.json", "r")
    json_data = load(json_file)
    # For each category
    for cat in json_data:
        catID:str = str(uuid.uuid4().hex)
        # Add category to categories table
        cursor.execute("INSERT INTO categories (CategoryID, Name, Image) VALUES ('{}', '{}', '{}')".format(catID, cat, json_data[cat]['image']))
        # For each subcategory in category
        for subcat in json_data[cat]["subcategories"]:
            subcatID:str = str(uuid.uuid4().hex)
            # Add subcategory to subcategories table
            cursor.execute("INSERT INTO subcategories (SubcategoryID, Name) VALUES ('{}', '{}')".format(subcatID, subcat))
            # For each product in subcategory
            for product in json_data[cat]["subcategories"][subcat]:
                # Add product to products table
                cursor.execute("INSERT INTO products (ProductID, Name, Image, Description, Price, BrandID, Rating, RatingCnt, TimeToExpire) VALUES ('{}', '{}', '{}', '{}', {}, '{}', {}, {}, '{}')"
                .format(str(product['id']), 
                        product['name'],
                        product['images'][0], 
                        product['description'], 
                        product['price'], 
                        get_brand_id(product['brand']), 
                        product['rating'], 
                        product['no_of_reviews'], 
                        random_date(60)
                        )
                )
                # Add product to product_categories table
                cursor.execute("INSERT INTO product_categories (ProductID, CategoryID, SubcategoryID) VALUES ('{}', '{}', '{}')".format(product['id'], catID, subcatID))
    db.commit()
    json_file.close()

def add_tests()->None:
    """Add data to tests table"""
    json_file = open("data/json/tests.json", "r")
    json_data = load(json_file)
    for test in json_data:
        cursor.execute("INSERT INTO tests (TestID, Name, Description, Price, LabID) VALUES ('{}', '{}', '{}', {}, '{}')".
        format(test['test_id'], test['name'], test['description'], test['price'], test['lab_id']))
    db.commit()
    json_file.close()

def add_product_orders()->None:
    """Add data to product_orders table"""
    json_file = open("data/json/product_orders.json", "r")
    json_data = load(json_file)
    for order in json_data:
        cursor.execute("INSERT INTO product_orders (OrderID, CustomerID, OrderDate, Quantity, Amount, Status, DeliveryMethod, PaymentMethod) VALUES ('{}', '{}', '{}', '{}', {}, '{}', '{}', '{}')"
        .format(order['order_id'], order['user_id'], order['order_date'], order['quantity'], order['amount'], order['status'], order['delivery_method'], order['payment_method']))
    db.commit()
    json_file.close()

def main()->None:
    """Main function"""
    global db, cursor
    db = sql.connect(
        host = "localhost",
        user = "root",
        passwd = "root",
        database = "DrugVeda"
    )
    cursor = db.cursor()
    # add_data_customers()
    # add_data_retailers()
    # add_data_suppliers()
    # add_data_labs()
    # add_data_products()
    # add_tests()
    # add_product_orders()
    db.close()

if __name__ == "__main__":
    main()
else:
    raise Exception("This file was not created to be imported")