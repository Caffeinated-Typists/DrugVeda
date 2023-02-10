from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.edge.options import Options as EdgeOptions
from datetime import datetime, timedelta
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from selenium.webdriver.edge.service import Service as EdgeService
from selenium.webdriver.common.by import By
from fake_useragent import UserAgent
from pprint import pprint
import selenium.common.exceptions
import time
import json
import logging
from datetime import datetime, timezone

from bs4 import BeautifulSoup


logging.basicConfig(filename="errorlogs.log", level=logging.INFO)
logger = logging.getLogger(__name__)


def User():

    ua = UserAgent()
    return ua.random


def makeProduct(name: str, price: float, brand: str, expiry_date: str, description: str, rating: str, no_of_reviews: str, images: list[str]):
    return {
        "name": str(name),
        "price": price,
        "brand": str(brand).title(),
        "expiry_date": str(expiry_date),
        "description": str(description),
        "rating": str(rating),
        "no_of_reviews": str(no_of_reviews),
        "images": images
    }


BASE_URL = "https://pharmeasy.in/"

edge_options = EdgeOptions()
options = [
    "--headless",
    "--disable-gpu",
    "--window-size=1920,1200",
    "--ignore-certificate-errors",
    "--disable-extensions",
    "--no-sandbox",
    "--disable-dev-shm-usage"
]

for option in options:
    edge_options.add_argument(option)
edge_options.add_argument(f'user-agent={User()}')
edge_options.add_experimental_option('excludeSwitches', ['enable-logging'])

browser = webdriver.Edge(service=EdgeService(
    EdgeChromiumDriverManager().install()), options=edge_options)

url = "https://pharmeasy.in/health-care"
browser.get(url)
browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")

# creating dictionary to store data
data = {}

logger.info("Start time: " + str(datetime.now()))
try:
    # iterating over every category
    idx_cat = 0
    no_of_cats = len(browser.find_element(
        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[2]/div/div').find_elements('xpath', r'*'))

    while(idx_cat < no_of_cats):
        # getting category
        categories = browser.find_element(
            'xpath', r'//*[@id="__next"]/main/div/div[2]/div[2]/div/div').find_elements('xpath', r'*')
        category = categories[idx_cat]

        # getting category info
        idx_cat += 1

        name = category.find_element('xpath', r'./div[2]/h2').text
        image = category.find_elements(By.TAG_NAME, 'img')[
            1].get_attribute('src')

        # clicking on category
        browser.execute_script('arguments[0].click()', category)
        time.sleep(0.5)

        # clicking on view more and finding no. of subcategories
        try:
            view_more_button = browser.find_element(
                'xpath', r'//*[@id="__next"]/main/div/div[2]/section[1]/div[1]/div/div[3]/div[2]')

            # adding category if subcategories exist
            data[name] = {"image": image, "subcategories": {}}
            subcats = data[name]["subcategories"]

        except selenium.common.exceptions.NoSuchElementException:
            all_cats_button = browser.find_element(
                "xpath", r'//*[@id="__next"]/main/div/div[1]/a[2]')
            browser.execute_script('arguments[0].click()', all_cats_button)
            continue

        browser.execute_script('arguments[0].click()', view_more_button)
        time.sleep(0.5)
        no_of_subcats = len((browser.find_element(
            "xpath", r'//*[@id="drawers-portal"]/div/div[2]/div[2]/div[2]')).find_elements('xpath', r'./label')) // 2

        # clicking on exit button
        exit_button = browser.find_element(
            "xpath", r'//*[@id="drawers-portal"]/div/div[2]/div[1]')
        browser.execute_script('arguments[0].click()', exit_button)

        idx_subcat = 0

        while(idx_subcat < no_of_subcats):
            view_more_button = browser.find_element(
                "xpath", r'//*[@id="__next"]/main/div/div[2]/section[1]/div[1]/div/div[3]/div[2]')
            browser.execute_script('arguments[0].click()', view_more_button)
            time.sleep(0.5)

            # getting subcategory
            all_subcats = (browser.find_element(
                "xpath", r'//*[@id="drawers-portal"]/div/div[2]/div[2]/div[2]')).find_elements('xpath', r'./label')
            browser.execute_script(
                'arguments[0].click()', all_subcats[idx_subcat])

            subcats[all_subcats[idx_subcat].text] = []
            products = subcats[all_subcats[idx_subcat].text]

            # clicking on apply button
            apply_button = browser.find_element(
                "xpath", r'//*[@id="drawers-portal"]/div/div[2]/div[2]/div[3]/button[2]')
            browser.execute_script('arguments[0].click()', apply_button)
            idx_subcat += 1

            time.sleep(1)
            all_products = (browser.find_element(
                "xpath", r'//*[@id="__next"]/main/div/div[2]/section[1]/div[2]/div[3]/div[1]').find_elements('xpath', r'./div'))
            no_of_products = len(all_products) // 2

            idx_product = 0
            while(idx_product < no_of_products):
                time.sleep(1)
                all_products = (browser.find_element(
                    "xpath", r'//*[@id="__next"]/main/div/div[2]/section[1]/div[2]/div[3]/div[1]').find_elements('xpath', r'./div'))
                url = (all_products[idx_product]).find_element(By.TAG_NAME, 'a').get_attribute('href')

                # opening new tab and going to product
                browser.execute_script("window.open('');")
                browser.switch_to.window(browser.window_handles[1])
                browser.get(url)
                idx_product += 1
                time.sleep(1)

                # getting product info
                try:
                    name = browser.find_element(
                        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/h1').text
                    price = float(browser.find_element(
                        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[1]/div[2]/div[1]/div[4]/div[1]/div[1]/div[1]/div').text[1:])
                    expiry_date = browser.find_element(
                        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[5]/div[4]/div/div[2]/div[2]').text
                    brand = browser.find_element(
                        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[5]/div[4]/div/div[1]/div[2]/span').text
                    description = browser.find_element(
                        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[5]/div[1]/div/div/div/div[1]/div').text
                    rating = browser.find_element(
                        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[7]/div/div[2]/div[1]/div/div/div[1]/div').text
                    no_of_reviews = int(((browser.find_element(
                        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[7]/div/div[2]/div[1]/div/div/div[3]').text).split())[0])
                    image_elements = browser.find_element(
                        "xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]').find_elements('xpath', r'./div/img')
                    images = [str(element.get_attribute('src'))
                              for element in image_elements]

                    product = makeProduct(
                        name, price, brand, expiry_date, description, rating, no_of_reviews, images)
                    products.append(product)
                except selenium.common.exceptions.NoSuchElementException:
                    continue

                except Exception as e:
                    logger.exception(e.with_traceback)

                finally:
                    # closing tab no matter what
                    browser.close()
                    browser.switch_to.window(browser.window_handles[0])
                    json.dump(data, open('json/products.json', 'w'), indent=2)

        all_cats_button = browser.find_element(
            "xpath", r'//*[@id="__next"]/main/div/div[1]/a[2]')
        browser.execute_script('arguments[0].click()', all_cats_button)

    print("Completed Scraping Successfully")


except Exception as e:
    print("UNEXPECTED ERROR OCCURED")
    logger.info("Something terrible happened")
    logger.exception(e)
    logger.info("\n")
finally:
    browser.quit()
    logger.info("End time : " + str(datetime.datetime.now()))
