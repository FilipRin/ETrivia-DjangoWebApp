import unittest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

# Filip Rinkovec 2019/0463

class MatchmakingTest(unittest.TestCase):

    def setUp(self):
        self.driver = webdriver.Chrome()
        self.driver.get("http://localhost:8000/etrivia/login")
    def test_matchmaking(self):
        #driver is first player browser
        driver=self.driver

        #Log in
        username = driver.find_element(By.NAME, "username")
        password = driver.find_element(By.NAME, "password")
        login_button = driver.find_element(By.CSS_SELECTOR, "input.submit-button")

        username.send_keys("cofi")
        password.send_keys("123")
        login_button.click()

        # Wait until login completes and main page loads
        try:
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CLASS_NAME, "icon"))
            )
            print("Main icon found.")
        except Exception as e:
            print("Failed to find the main icon: ", e)
            driver.save_screenshot('main_icon_not_found.png')
            raise

        driver.get('http://localhost:8000/etrivia/matchmaking')
        #webBrowser is second player browser
        webBrowser = webdriver.Edge()
        webBrowser.get("http://localhost:8000/etrivia/login")
        #driver = self.driver
        username = webBrowser.find_element(By.NAME, "username")
        password = webBrowser.find_element(By.NAME, "password")
        login_button = webBrowser.find_element(By.CSS_SELECTOR, "input.submit-button")

        username.send_keys("tasha1")
        password.send_keys("123")
        login_button.click()

        # Wait until login completes and main page loads
        try:
            WebDriverWait(webBrowser, 10).until(
                EC.presence_of_element_located((By.CLASS_NAME, "icon"))
            )
            print("Main icon found.")
        except Exception as e:
            print("Failed to find the main icon: ", e)
            webBrowser.save_screenshot('main_icon_not_found.png')
            raise

        webBrowser.get('http://localhost:8000/etrivia/matchmaking')
        #if alert pops up
        try:
            WebDriverWait(webBrowser, 3).until(EC.alert_is_present())
            webBrowser.switch_to.alert.accept()
        except Exception as e:
            print("no alert")

        #if the game started
        try:
            WebDriverWait(webBrowser, 20).until(EC.presence_of_element_located((By.ID, 'numberhunt_question')))
            print("First game found.")
        except Exception as e:
            print("Failed to find the main icon: ", e)
            webBrowser.save_screenshot('main_icon_not_found.png')
            raise

        # if alert pops up
        try:
            WebDriverWait(driver, 3).until(EC.alert_is_present())
            driver.switch_to.alert.accept()
        except Exception as e:
            print("no alert")

        self.assertTrue(EC.presence_of_element_located((By.ID,'numberhunt_question')))  # add assertion here
        webBrowser.quit()

    def tearDown(self):
        self.driver.quit()


if __name__ == '__main__':
    unittest.main()
