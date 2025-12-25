# Appium Test Cases - Laza E-commerce App

## Overview

This document describes the two mandatory Appium tests for the Laza E-commerce Flutter application.

---

## Test 1: Authentication Flow (`test_auth.py`)

### Test ID
`TC_AUTH_001`

### Description
Validates the complete authentication flow from signup to login to home screen.

### Preconditions
- Appium server running on `localhost:4723`
- Android emulator or physical device connected
- Fresh app installation (no existing user data)

### Test Steps

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Launch the app | Login screen is displayed |
| 2 | Tap "Sign Up" link | Signup screen is displayed |
| 3 | Enter email in email field | Email is entered |
| 4 | Enter password in password field | Password is entered (masked) |
| 5 | Enter password in confirm password field | Password is confirmed |
| 6 | Tap "Sign Up" button | Account is created, redirected to Login screen |
| 7 | Enter email in login email field | Email is entered |
| 8 | Enter password in login password field | Password is entered |
| 9 | Tap "Login" button | User is logged in |
| 10 | Verify Home screen | Home screen with products is displayed |

### Expected Result
- User successfully creates an account
- User successfully logs in
- Home screen is displayed with search bar and cart icon

### Test Data
- Email: `test_{timestamp}@example.com` (dynamically generated)
- Password: `Test123456`

---

## Test 2: Cart Flow (`test_cart.py`)

### Test ID
`TC_CART_001`

### Description
Validates the cart functionality from adding a product to viewing it in the cart.

### Preconditions
- Appium server running on `localhost:4723`
- Android emulator or physical device connected
- User is already logged in (run `test_auth.py` first or login manually)
- Products are loaded from the API

### Test Steps

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | Wait for Home screen | Products grid is displayed |
| 2 | Tap on first product | Product detail screen is displayed |
| 3 | Tap "Add to Cart" button | Product is added to cart, snackbar confirmation shown |
| 4 | Navigate back to Home | Home screen is displayed |
| 5 | Tap cart icon | Cart screen is displayed |
| 6 | Verify cart item | Added product is visible in cart |
| 7 | Verify checkout button | Checkout button is visible |

### Expected Result
- Product is successfully added to cart
- Cart screen shows the added product
- Checkout button is available

---

## Element Keys Reference

The following accessibility keys are used in the tests:

### Login Screen
- `email_field` - Email input field
- `password_field` - Password input field
- `login_button` - Login button
- `signup_link` - Link to signup screen

### Signup Screen
- `signup_email_field` - Email input field
- `signup_password_field` - Password input field
- `signup_confirm_password_field` - Confirm password field
- `signup_button` - Signup button

### Home Screen
- `search_field` - Search input field
- `cart_icon` - Cart icon button
- `product_{id}` - Product card (e.g., `product_1`, `product_2`)

### Product Detail Screen
- `add_to_cart_button` - Add to cart button
- `favorite_button` - Add to favorites button

### Cart Screen
- `cart_item_{id}` - Cart item (e.g., `cart_item_1`)
- `checkout_button` - Checkout button

---

## Running the Tests

See `README.md` in the `appium_tests` folder for detailed instructions.
