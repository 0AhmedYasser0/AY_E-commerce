# Appium Test Cases Documentation (JavaScript/Node.js)

This document provides comprehensive documentation for the two mandatory Appium test cases for the E-commerce Flutter application using JavaScript and WebDriverIO.

---

## Test Case 1: Authentication Test (`auth_test.js`)

### Test Description
This test validates the authentication flow of the application. It verifies that a user can successfully log in to the application and reach the home screen.

**Test Scenario:** Open App → Enter Email → Enter Password → Click Login → Verify User is on Home Screen

### Pre-conditions
- Appium server must be running on `localhost:4723`
- Android emulator or physical device is connected and accessible
- Application APK is installed or the correct path is configured in the test script
- Test user account exists in the system (email: `test@example.com`, password: `test123456`)
- Node.js is installed on the system
- WebDriverIO dependency is installed (`npm install`)

### Test Steps

| Step | Action | Details |
|------|--------|---------|
| 1 | Open App | Launch the application on the device/emulator |
| 2 | Enter Email | Locate email field using `~email_field` (accessibility id) and input test email |
| 3 | Enter Password | Locate password field using `~password_field` (accessibility id) and input test password |
| 4 | Click Login | Locate login button using `~login_button` (accessibility id) and click it |
| 5 | Verify Home Screen | Verify that the home screen is displayed by checking for `~search_field` (accessibility id) |

### Expected Results
- Application launches successfully
- Email field accepts input correctly
- Password field accepts input correctly (text is masked)
- Login button is clickable and triggers authentication
- User is successfully authenticated and navigated to the home screen
- Home screen elements (search field) are visible and accessible

---

## Test Case 2: Cart Test (`cart_test.js`)

### Test Description
This test validates the shopping cart functionality of the application. It verifies that a user can add a product to the cart and view it in the cart screen.

**Test Scenario:** Click first product on Home Screen → Click "Add to Cart" → Click Back → Click Cart Icon → Verify item count is 1

### Pre-conditions
- Appium server must be running on `localhost:4723`
- Android emulator or physical device is connected and accessible
- Application APK is installed or the correct path is configured in the test script
- User must be logged in (run `auth_test.js` first or login manually before running this test)
- Products are loaded and displayed on the home screen
- Server/API is running and accessible
- Node.js is installed on the system
- WebDriverIO dependency is installed (`npm install`)

### Test Steps

| Step | Action | Details |
|------|--------|---------|
| 1 | Click first product | Locate first product on home screen using xpath `//*[contains(@content-desc, "product_")]` and click it |
| 2 | Click "Add to Cart" | Locate add to cart button using `~add_to_cart_button` (accessibility id) and click it |
| 3 | Click Back | Navigate back to home screen using device back button (`driver.back()`) |
| 4 | Click Cart Icon | Locate cart icon using `~cart_icon` (accessibility id) and click it |
| 5 | Verify item count | Verify that at least one cart item is present using xpath `//*[contains(@content-desc, "cart_item_")]` |

### Expected Results
- First product on home screen is clickable and opens product detail screen
- Product detail screen displays correctly with product information
- "Add to Cart" button is visible and clickable
- Product is successfully added to cart (confirmation may be shown)
- Back navigation returns user to home screen
- Cart icon is visible and clickable on home screen
- Cart screen opens and displays the added product
- Cart item count is 1 (one item in cart)

---

## Element Locator Strategies

The tests use the following locator strategies with WebDriverIO:

### Accessibility ID (Primary Strategy)
WebDriverIO uses the `~` prefix for accessibility IDs:
- `~email_field` - Email input field on login screen
- `~password_field` - Password input field on login screen
- `~login_button` - Login button on login screen
- `~add_to_cart_button` - Add to cart button on product detail screen
- `~cart_icon` - Cart icon on home screen
- `~search_field` - Search field on home screen (used for verification)

### XPath (Secondary Strategy)
- `//*[contains(@content-desc, "product_")]` - Locates product items on home screen
- `//*[contains(@content-desc, "cart_item_")]` - Locates cart items on cart screen

---

## Setup Instructions

### 1. Install Node.js
Ensure Node.js (v14 or higher) is installed on your system:
```bash
node --version
npm --version
```

### 2. Install Dependencies
Navigate to the `appium_tests` folder and install WebDriverIO:
```bash
cd appium_tests
npm install
```

### 3. Configure Test Scripts
Before running the tests, update the following placeholders in the test scripts:

**In `auth_test.js`:**
- Line 21: Update device name if needed (`'appium:deviceName': 'Android Emulator'`)
- Line 22: Update APK path to your actual APK location (`'appium:app': './builds/apk/app-release.apk'`)
- Line 42: Replace with your test email (`await emailField.setValue('test@example.com')`)
- Line 48: Replace with your test password (`await passwordField.setValue('test123456')`)
- Line 60: Replace with your home screen element ID if different (`await driver.$('~search_field')`)

**In `cart_test.js`:**
- Line 21: Update device name if needed (`'appium:deviceName': 'Android Emulator'`)
- Line 22: Update APK path to your actual APK location (`'appium:app': './builds/apk/app-release.apk'`)

### 4. Start Appium Server
Open a terminal and start the Appium server:
```bash
appium
```

The server should start on `http://localhost:4723`

### 5. Run Tests
Use npm scripts to run the tests:

```bash
# Run authentication test
npm run test:auth

# Run cart test (ensure user is logged in first)
npm run test:cart
```

Alternatively, run directly with Node.js:
```bash
node auth_test.js
node cart_test.js
```

---

## Troubleshooting

### Common Issues

**1. "Cannot find module 'webdriverio'"**
- Solution: Run `npm install` in the `appium_tests` folder

**2. "Appium server not responding"**
- Solution: Ensure Appium server is running on `localhost:4723`
- Check with: `curl http://localhost:4723/status`

**3. "Element not found"**
- Solution: Verify Flutter Keys are correctly set in the app
- Increase wait timeout in test scripts
- Check element accessibility IDs match between app and tests

**4. "Session not created"**
- Solution: Verify device/emulator is connected
- Check with: `adb devices`
- Ensure APK path is correct

**5. "Cart test fails - user not logged in"**
- Solution: Run `auth_test.js` first to log in
- Or manually log in before running cart test

---

## Notes
- Tests use `accessibility_id` as the primary locator strategy for better reliability
- XPath is used as a fallback for dynamic elements (products, cart items)
- The cart test requires the user to be logged in before execution
- Wait times (`pause`) are included to allow for network requests and UI rendering
- All Flutter widgets have been configured with appropriate Key values for testing
- WebDriverIO uses async/await syntax for cleaner, more readable test code
- The `~` prefix in WebDriverIO is shorthand for accessibility ID selector

---

## Migration from Python

This test suite has been migrated from Python (Appium-Python-Client) to JavaScript (WebDriverIO) to avoid environment issues. Key differences:

- **Python**: Used `AppiumBy.ACCESSIBILITY_ID` → **JavaScript**: Uses `~` prefix
- **Python**: `find_element()` → **JavaScript**: `$()` selector
- **Python**: `time.sleep()` → **JavaScript**: `await driver.pause()`
- **Python**: Synchronous → **JavaScript**: Async/await pattern
- **Dependency Management**: `requirements.txt` → `package.json`
