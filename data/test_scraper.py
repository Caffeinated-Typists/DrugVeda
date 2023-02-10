from selenium import webdriver
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


def makeTest(name: str, price: float, description: str):
    return {
        "name": str(name),
        "price": price,
        "description": str(description),
    }


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

url = "https://pharmeasy.in/diagnostics/all-tests"
browser.get(url)

# creating array
data = []

try:
    # waiting and scrolling in page
    current_scroll_position, new_height= 0, 1
    speed = 20
    while current_scroll_position <= new_height:
        current_scroll_position += speed
        browser.execute_script("window.scrollTo(0, {});".format(current_scroll_position))
        new_height = browser.execute_script("return document.body.scrollHeight")

    # getting all the tests
    tests = browser.find_element("xpath", r'//*[@id="content-container"]/div[1]/div')
    all_tests = tests.find_elements(By.TAG_NAME, "a")
    print(len(all_tests))

    for test in all_tests:
        # open link in new tab
        url = test.get_attribute("href")

        browser.execute_script("window.open('');")
        browser.switch_to.window(browser.window_handles[1])
        browser.get(url)
        
        test_info = browser.find_element("xpath", r'//*[@id="content-container"]/div[1]')
        number_of_elements = len(test_info.find_elements(By.TAG_NAME, "div"))

        # getting name and price
        name = browser.find_element("xpath", r'//*[@id="content-container"]/div[1]/div[2]/div[1]/div/div[1]/h1').text
        try:
            price = browser.find_element("xpath", r'//*[@id="content-container"]/div[1]/div[2]/div[1]/div/div[3]').text
        except:
            price = browser.find_element("xpath", r'//*[@id="content-container"]/div[1]/div[2]/div[1]/div/div[2]').text

        price = price.replace("₹", "")
        price = price.replace(",", "")
        price = int(price.split()[0])

        description = browser.find_element(By.CLASS_NAME, '_32yDO').text
        

        browser.close()

        # creating test object
        test = makeTest(name, price, description)
        data.append(test)
        json.dump(data, open("json/tests.json", "w"), indent=2)
        browser.switch_to.window(browser.window_handles[0])




except Exception as e:
    print("UNEXPECTED ERROR OCCURED")
    logger.info("Something terrible happened")
    logger.exception(e)
    logger.info("\n")
finally:
    browser.quit()
    logger.info("End time : " + str(datetime.now()))
