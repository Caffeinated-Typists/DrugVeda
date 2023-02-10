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
    db.close()

if __name__ == "__main__":
    main()
else:
    raise Exception("This file was not created to be imported")