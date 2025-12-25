"""
Appium Test: Cart Flow
Test Flow: Open product → Add to cart → Open cart → Validate item exists

Prerequisites:
- Appium server running on localhost:4723
- Android emulator or device connected
- App APK installed or path configured
- User must be logged in (run test_auth.py first or login manually)
"""

import unittest
import time
from appium import webdriver
from appium.options.android import UiAutomator2Options
from appium.webdriver.common.appiumby import AppiumBy
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC


class TestCartFlow(unittest.TestCase):
    """Test cart flow: Open product → Add to cart → Validate"""

    def setUp(self):
        """Set up Appium driver"""
        options = UiAutomator2Options()
        options.platform_name = "Android"
        options.device_name = "Android Emulator"
        options.app = "./builds/apk/app-release.apk"  # Update path as needed
        options.automation_name = "UiAutomator2"
        options.no_reset = True  # Keep app state (logged in)
        
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

    def test_cart_flow(self):
        """
        Test complete cart flow:
        1. Wait for products to load on Home screen
        2. Open first product
        3. Add product to cart
        4. Navigate to cart
        5. Validate item exists in cart
        """
        # Step 1: Wait for Home screen and products to load
        print("Step 1: Waiting for products to load...")
        time.sleep(3)  # Wait for products to load from API

        # Step 2: Open first product
        print("Step 2: Opening first product...")
        
        # Find and click on a product (using partial accessibility ID)
        # Products have keys like 'product_1', 'product_2', etc.
        first_product = self.wait.until(
            EC.element_to_be_clickable((AppiumBy.XPATH, "//*[contains(@content-desc, 'product_')]"))
        )
        first_product.click()
        time.sleep(2)

        # Step 3: Add product to cart
        print("Step 3: Adding product to cart...")
        
        add_to_cart_button = self.wait.until(
            EC.element_to_be_clickable((AppiumBy.ACCESSIBILITY_ID, "add_to_cart_button"))
        )
        add_to_cart_button.click()
        time.sleep(2)

        # Step 4: Navigate back and go to cart
        print("Step 4: Navigating to cart...")
        
        # Go back to home
        self.driver.back()
        time.sleep(1)

        # Click on cart icon
        cart_icon = self.wait.until(
            EC.element_to_be_clickable((AppiumBy.ACCESSIBILITY_ID, "cart_icon"))
        )
        cart_icon.click()
        time.sleep(2)

        # Step 5: Validate item exists in cart
        print("Step 5: Validating item exists in cart...")
        
        # Look for cart item (cart items have keys like 'cart_item_1', etc.)
        cart_item = self.wait.until(
            EC.presence_of_element_located((AppiumBy.XPATH, "//*[contains(@content-desc, 'cart_item_')]"))
        )
        self.assertIsNotNone(cart_item, "Cart should contain the added item")

        # Verify checkout button is visible (indicates cart has items)
        checkout_button = self.driver.find_element(
            AppiumBy.ACCESSIBILITY_ID, "checkout_button"
        )
        self.assertIsNotNone(checkout_button, "Checkout button should be visible")

        print("✅ Cart flow test PASSED!")


if __name__ == "__main__":
    unittest.main(verbosity=2)
