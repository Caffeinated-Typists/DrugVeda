import json
import uuid



def add_id(data):
    """helper function which added id to all products"""
    data = {}

    with open("json/products.json", "r") as f:
        data = json.load(f)
        count = 0
        for category in data:
            for subcategory in data[category]["subcategories"]:
                for product in data[category]["subcategories"][subcategory]:
                    product["id"] = uuid.uuid1().hex


    json.dump(data, open("json/products.json", "w"), indent=2)