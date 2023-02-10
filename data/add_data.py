import mysql.connector as sql
from json import load
import typing

db:sql.connect = None
cursor:sql.cursor = None

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
    add_data_suppliers()
    db.close()

if __name__ == "__main__":
    main()
else:
    raise Exception("This file was not created to be imported")