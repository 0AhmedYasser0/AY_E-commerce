"""
Appium Test: Authentication Flow
Test Flow: Open app → Signup → Login → Home

Prerequisites:
- Appium server running on localhost:4723
- Android emulator or device connected
- App APK installed or path configured
"""

import unittest
import time
from appium import webdriver
from appium.options.android import UiAutomator2Options
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class TestAuthFlow(unittest.TestCase):
    """Test authentication flow: Signup → Login → Home"""

    def setUp(self):
        """Set up Appium driver"""
        options = UiAutomator2Options()
        options.platform_name = "Android"
        options.device_name = "Android Emulator"
        options.app = "./builds/apk/app-release.apk"  # Update path as needed
        options.automation_name = "UiAutomator2"
        options.no_reset = False
        
        self.driver = webdriver.Remote(
            command_executor="http://localhost:4723",
            options=options
        )
        self.driver.implicitly_wait(10)
        self.wait = WebDriverWait(self.driver, 20)

    def tearDown(self):
        """Quit driver after test"""
        if self.driver:
            self.driver.quit()

    def test_auth_flow(self):
        """
        Test complete authentication flow:
        1. Navigate to Signup screen
        2. Create new account
        3. Login with created account
        4. Verify Home screen is displayed
        """
        # Generate unique test email
        test_email = f"test_{int(time.time())}@example.com"
        test_password = "Test123456"

        # Step 1: Navigate to Signup
        print("Step 1: Navigating to Signup screen...")
        signup_link = self.wait.until(
            EC.element_to_be_clickable((AppiumBy.ACCESSIBILITY_ID, "signup_link"))
        )
        signup_link.click()
        time.sleep(1)

        # Step 2: Fill Signup form
        print("Step 2: Filling Signup form...")
        
        # Enter email
        email_field = self.wait.until(
            EC.presence_of_element_located((AppiumBy.ACCESSIBILITY_ID, "signup_email_field"))
        )
        email_field.send_keys(test_email)

        # Enter password
        password_field = self.driver.find_element(
            AppiumBy.ACCESSIBILITY_ID, "signup_password_field"
        )
        password_field.send_keys(test_password)

        # Confirm password
        confirm_password_field = self.driver.find_element(
            AppiumBy.ACCESSIBILITY_ID, "signup_confirm_password_field"
        )
        confirm_password_field.send_keys(test_password)

        # Click Signup button
        signup_button = self.driver.find_element(
            AppiumBy.ACCESSIBILITY_ID, "signup_button"
        )
        signup_button.click()
        time.sleep(3)  # Wait for account creation

        # Step 3: Login with created account
        print("Step 3: Logging in with created account...")
        
        # Enter email on login screen
        login_email_field = self.wait.until(
            EC.presence_of_element_located((AppiumBy.ACCESSIBILITY_ID, "email_field"))
        )
        login_email_field.send_keys(test_email)

        # Enter password
        login_password_field = self.driver.find_element(
            AppiumBy.ACCESSIBILITY_ID, "password_field"
        )
        login_password_field.send_keys(test_password)

        # Click Login button
        login_button = self.driver.find_element(
            AppiumBy.ACCESSIBILITY_ID, "login_button"
        )
        login_button.click()
        time.sleep(3)  # Wait for login

        # Step 4: Verify Home screen
        print("Step 4: Verifying Home screen is displayed...")
        
        # Check for search field (indicates Home screen)
        search_field = self.wait.until(
            EC.presence_of_element_located((AppiumBy.ACCESSIBILITY_ID, "search_field"))
        )
        self.assertIsNotNone(search_field, "Home screen should be displayed after login")

        # Check for cart icon
        cart_icon = self.driver.find_element(
            AppiumBy.ACCESSIBILITY_ID, "cart_icon"
        )
        self.assertIsNotNone(cart_icon, "Cart icon should be visible on Home screen")

        print("✅ Auth flow test PASSED!")


if __name__ == "__main__":
    unittest.main(verbosity=2)
