import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from getpass import getpass

brave_path = "/usr/bin/brave"
chromedriver_path = "/usr/bin/chromedriver"
options = webdriver.ChromeOptions()
options.binary_location = brave_path
service = Service(chromedriver_path)
driver = webdriver.Chrome(service=service, options=options)

def login_instagram(username, password):
    driver.get("https://www.instagram.com")
    WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.XPATH, "//input[@placeholder='Phone number, username, or email']"))
    )
    username_input = driver.find_element(By.XPATH, "//input[@placeholder='Phone number, username, or email']")
    password_input = driver.find_element(By.XPATH, "//input[@placeholder='Password']")
    username_input.send_keys(username)
    password_input.send_keys(password)
    password_input.submit()

def unfollow_users(url, num_unfollows):
    driver.get(url)
    unfollowed_count = 0
    while unfollowed_count < num_unfollows:
        try:
            following_buttons = driver.find_elements(By.XPATH, "//button[text()='Following']")
            for button in following_buttons:
                if unfollowed_count >= num_unfollows:
                    break
                button.click()
                unfollow_button = WebDriverWait(driver, 10).until(
                    EC.element_to_be_clickable((By.XPATH, "//button[text()='Unfollow']"))
                )
                unfollow_button.click()
                unfollowed_count += 1
                time.sleep(2)
            driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(2)
        except Exception as e:
            print(f"An error occurred: {e}")
            break
    print(f"Successfully unfollowed {unfollowed_count} users.")
    driver.quit()

username = input("Enter your Instagram username: ")
password = getpass("Enter your Instagram password: ")
login_instagram(username, password)
following_url = "https://www.instagram.com/jakubhalikphoto/following/"
num_unfollows = 524
unfollow_users(following_url, num_unfollows)

