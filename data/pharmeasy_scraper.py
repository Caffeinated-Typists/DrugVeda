from selenium import webdriver
from selenium.webdriver.edge.options import Options as EdgeOptions
from datetime import datetime, timedelta
from webdriver_manager.microsoft import EdgeChromiumDriverManager
from selenium.webdriver.edge.service import Service as EdgeService
from selenium.webdriver.common.by import By
from fake_useragent import UserAgent
import selenium.common.exceptions
import time
import json
import logging 

logging.basicConfig(filename="errorlogs.log", level=logging.INFO)
logger = logging.getLogger(__name__)


def User():
    
    ua = UserAgent()
    return ua.random

def makeProduct(name:str, price:int, brand:str, expiry_date:str, description:str, rating:str, no_of_reviews:str, images:list[str]):
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

browser = webdriver.Edge(service=EdgeService(EdgeChromiumDriverManager().install()), options=edge_options)

url = "https://pharmeasy.in/health-care"
browser.get(url)
browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
time.sleep(1)

# creating dictionary to store data
data = {}

try:
    Cats = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[2]/div/div')
    Containers = Cats.find_elements("xpath", "*")

    for container in Containers:

        # Going into a category
        name = container.find_element("xpath", r'./div[2]/h2').text
        browser.execute_script('arguments[0].click()', container)
        
        # adding category to dictionary, and initializing it's subcategory
        data[name] = {}
        subcat_content = data[name]

        #clicking on view more button
        view_more_button = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/section[1]/div[1]/div/div[3]/div[2]')
        browser.execute_script('arguments[0].click()', view_more_button)
        time.sleep(1)

        # getting subcats and exiting
        exit_button = browser.find_element("xpath", r'//*[@id="drawers-portal"]/div/div[2]/div[1]')
        subcats = (browser.find_element("xpath", r'//*[@id="drawers-portal"]/div/div[2]/div[2]/div[2]')).find_elements('xpath', r'./label')
        no_of_subcats = len(subcats)
        # time.sleep(1)
        browser.execute_script('arguments[0].click()', exit_button)
        time.sleep(1)


        # interating over every subcategory
        idx_subcat = 0
        while(idx_subcat < no_of_subcats):
            #clicking on view more button
            view_more_button = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/section[1]/div[1]/div/div[3]/div[2]')
            browser.execute_script('arguments[0].click()', view_more_button)
            time.sleep(1)

            #getting specific subcat and clicking it
            subcats = (browser.find_element("xpath", r'//*[@id="drawers-portal"]/div/div[2]/div[2]/div[2]')).find_elements('xpath', r'./label')
            browser.execute_script('arguments[0].click()', subcats[idx_subcat])
            idx_subcat += 1
            apply_button = browser.find_element("xpath", r'//*[@id="drawers-portal"]/div/div[2]/div[2]/div[3]/button[2]')

            # adding subcategory to list, and initializing it's products
            subcat_content[subcats[idx_subcat].text] = []
            products_content = subcat_content[subcats[idx_subcat].text]

            browser.execute_script('arguments[0].click()', apply_button)
            time.sleep(1)
            
            
            # getting count of products
            no_of_products = len(browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/section[1]/div[2]/div[3]/div[1]').find_elements('xpath', r'./div'))
            temp = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/section[1]/div[2]/div[3]/div[1]').find_elements('xpath', r'./div')

            # iterating over every product
            idx_product = 0
            while(idx_product < no_of_products):
                # getting product
                products = (browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/section[1]/div[2]/div[3]/div[1]').find_elements('xpath', r'./div'))
                url = (products[idx_product]).find_element('xpath', r'./a').get_attribute('href')

                # opening new tab and going to product
                browser.execute_script("window.open('');")
                browser.switch_to.window(browser.window_handles[1])
                browser.get(url)
                time.sleep(1)

                # getting product info
                # if it doesn't exist then skip
                try:
                    name = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/h1').text
                    try:
                        price = int(browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[1]/div[2]/div/div[4]/div[1]/div[1]/div[1]').text[1:])
                    except ValueError:
                        continue
                    brand = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[4]/div[4]/div/div[1]/div[2]').text
                    expiry_date = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[4]/div[4]/div/div[2]/div[2]').text
                    description = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[4]/div[1]/div/div/div/div[1]/div').text
                    rating = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[6]/div/div[2]/div[1]/div/div/div[1]/div').text
                    no_of_reviews = int(((browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[6]/div/div[2]/div[1]/div/div/div[3]').text).split())[0])
                    
                    # getting images
                    image_elements = browser.find_element("xpath", r'//*[@id="__next"]/main/div/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/div[2]').find_elements('xpath', r'./div/img')
                    images = [str(element.get_attribute('src')) for element in image_elements]

                    # creating product object
                    product = makeProduct(name, price, brand, expiry_date, description, rating, no_of_reviews, images)
                    products_content.append(product)
                    json.dump(data, open("data.json", "w"), indent=2)
                except selenium.common.exceptions.NoSuchElementException as e:
                    pass
                
                except Exception as e:
                    logger.exception(e)
                    logger.info(f"URL - {browser.current_url}\n")

                browser.close()
                browser.switch_to.window(browser.window_handles[0])

                #updating index
                idx_product += 1

            
            browser.back()

        

        
        
except selenium.common.exceptions.NoSuchElementException:
    print("No such element")

except Exception as e:
    logger.exception(e.with_traceback)
    logger.info()
    logger.info(f"URL - {browser.current_url}\n")
finally:
    json.dump(data, open("data.json", "w"), indent=2)
    browser.quit()