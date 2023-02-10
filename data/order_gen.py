import json
import uuid
from random import randint
from random import sample


def add_id(data):
    """helper function which added id to all products"""
    data = {}

    with open("json/products.json", "r") as f:
        data = json.load(f)
        for category in data:
            for subcategory in data[category]["subcategories"]:
                for product in data[category]["subcategories"][subcategory]:
                    product["id"] = uuid.uuid1().hex


    json.dump(data, open("json/products.json", "w"), indent=2)


def create_order_item(product:tuple[str, float], user:str, retailer:str) -> dict:
    """creates a single order item
    generate amount and ordrr id randomly, calculate amount based on quantity"""
    order:dict[str] = {}

    order_id = uuid.uuid1().hex
    quantity = randint(1, 10)
    amount = quantity * product[1]

    order["order_id"] = order_id
    order["product_id"] = product[0]
    order["user_id"] = user
    order["retailer_id"] = retailer
    order["quantity"] = quantity
    order["amount"] = amount

    return order


def product_order_items_gen():
    """generates order items for suing products.json, users.json and retailers.json"""
    product_ids:list[tuple(str, float)] = []

    # storing all product IDs
    with open("json/products.json", "r") as f:
        data = json.load(f)
        
        for category in data:
            for subcategory in data[category]["subcategories"]:
                for product in data[category]["subcategories"][subcategory]:
                    product_ids.append((product["id"], product["price"]))
    
    # storing all user IDs
    user_ids:list[str] = []
    with open("json/users.json", "r") as f:
        data = json.load(f)
        for user in data:
            user_ids.append(user["user_id"])

    # storing all retailer IDs
    retailer_ids:list[str] = []
    with open("json/retailers.json", "r") as f:
        data = json.load(f)
        for retailer in data:
            retailer_ids.append(retailer["retailer_id"])
    
    # generating order items
    order_items:list[dict[str]] = []
    for _ in range(100):
        order_items.append(
            create_order_item(
                sample(product_ids, 1)[0],
                sample(user_ids, 1)[0],
                sample(retailer_ids, 1)[0]
            )
        )
        
    # dumping order items into order.json
    json.dump(order_items, open("json/order.json", "w"), indent=2)



if __name__ == "__main__":
    product_order_items_gen()