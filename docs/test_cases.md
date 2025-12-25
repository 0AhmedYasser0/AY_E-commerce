# Test Cases Documentation - Laza E-commerce App

## Overview

This document provides a comprehensive overview of all test cases for the Laza E-commerce Flutter application.

---

## Test Categories

1. **Appium E2E Tests** - Automated mobile UI tests
2. **Manual Test Cases** - For instructor verification

---

## Appium E2E Tests

### Test 1: Authentication Flow

| Field | Value |
|-------|-------|
| **Test ID** | TC_AUTH_001 |
| **Test Name** | Authentication Flow Test |
| **Test File** | `appium_tests/test_auth.py` |
| **Priority** | High |
| **Type** | End-to-End |

**Test Flow:**
```
App Launch → Login Screen → Signup Screen → Create Account → 
Login Screen → Enter Credentials → Login → Home Screen
```

**Assertions:**
- Signup form accepts valid email and password
- Account is created successfully
- Login with new credentials succeeds
- Home screen is displayed after login

---

### Test 2: Cart Flow

| Field | Value |
|-------|-------|
| **Test ID** | TC_CART_001 |
| **Test Name** | Cart Flow Test |
| **Test File** | `appium_tests/test_cart.py` |
| **Priority** | High |
| **Type** | End-to-End |

**Test Flow:**
```
Home Screen → Product Grid → Tap Product → Product Detail → 
Add to Cart → Back to Home → Cart Screen → Verify Item
```

**Assertions:**
- Products load from API
- Product detail screen displays correctly
- Add to cart button works
- Cart contains added item
- Checkout button is visible

---

## Manual Test Cases

### Authentication Module

| Test ID | Test Case | Steps | Expected Result |
|---------|-----------|-------|-----------------|
| TC_AUTH_002 | Valid Login | 1. Enter valid email 2. Enter valid password 3. Tap Login | User is logged in, Home screen displayed |
| TC_AUTH_003 | Invalid Login | 1. Enter invalid email 2. Enter any password 3. Tap Login | Error message displayed |
| TC_AUTH_004 | Password Reset | 1. Tap "Forgot Password" 2. Enter email 3. Tap Send | Success dialog shown |
| TC_AUTH_005 | Logout | 1. Go to Profile 2. Tap Logout 3. Confirm | User logged out, Login screen displayed |

### Products Module

| Test ID | Test Case | Steps | Expected Result |
|---------|-----------|-------|-----------------|
| TC_PROD_001 | Load Products | 1. Login 2. View Home screen | Products grid displayed |
| TC_PROD_002 | Search Products | 1. Enter search term 2. View results | Filtered products shown |
| TC_PROD_003 | View Product Detail | 1. Tap on product | Product detail screen with image, title, price, description |

### Cart Module

| Test ID | Test Case | Steps | Expected Result |
|---------|-----------|-------|-----------------|
| TC_CART_002 | Add to Cart | 1. Open product 2. Tap "Add to Cart" | Item added, snackbar shown |
| TC_CART_003 | Update Quantity | 1. Go to Cart 2. Tap +/- buttons | Quantity updated |
| TC_CART_004 | Remove from Cart | 1. Go to Cart 2. Tap delete icon 3. Confirm | Item removed |
| TC_CART_005 | Checkout | 1. Go to Cart 2. Tap Checkout 3. Confirm | Success screen, cart cleared |
| TC_CART_006 | Empty Cart State | 1. Clear all items 2. View Cart | Empty state message displayed |

### Favorites Module

| Test ID | Test Case | Steps | Expected Result |
|---------|-----------|-------|-----------------|
| TC_FAV_001 | Add to Favorites | 1. Open product 2. Tap heart icon | Item added to favorites |
| TC_FAV_002 | Remove from Favorites | 1. Go to Favorites 2. Tap heart icon | Item removed |
| TC_FAV_003 | Empty Favorites State | 1. Remove all favorites 2. View Favorites | Empty state message displayed |

### Profile Module

| Test ID | Test Case | Steps | Expected Result |
|---------|-----------|-------|-----------------|
| TC_PROF_001 | View Profile | 1. Tap Profile tab | User email and info displayed |
| TC_PROF_002 | Logout | 1. Tap Logout 2. Confirm | User logged out |

---

## Test Environment

| Component | Requirement |
|-----------|-------------|
| **Platform** | Android 8.0+ / iOS 12.0+ |
| **Flutter** | 3.x |
| **Firebase** | Configured with Auth + Firestore |
| **Network** | Internet connection required |
| **Appium** | 2.x with UiAutomator2 driver |

---

## Test Data

| Data Type | Value |
|-----------|-------|
| Test Email | `test_{timestamp}@example.com` |
| Test Password | `Test123456` |
| API Endpoint | `https://api.escuelajs.co/api/v1/products` |

---

## Running Tests

### Appium Tests
```bash
# Start Appium server
appium

# Run auth test
python appium_tests/test_auth.py

# Run cart test
python appium_tests/test_cart.py
```

### Manual Tests
Follow the steps in each test case and verify expected results.

---

## Test Results Template

| Test ID | Status | Date | Tester | Notes |
|---------|--------|------|--------|-------|
| TC_AUTH_001 | PASS/FAIL | | | |
| TC_CART_001 | PASS/FAIL | | | |
