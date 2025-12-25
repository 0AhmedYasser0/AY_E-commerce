# Appium Tests - Laza E-commerce App

## Prerequisites

### 1. Install Python Dependencies

```bash
pip install Appium-Python-Client selenium
```

### 2. Install Appium

```bash
npm install -g appium
appium driver install uiautomator2
```

### 3. Set Up Android Environment

- Install Android Studio
- Set up Android SDK
- Create an Android emulator or connect a physical device
- Enable USB debugging on physical devices

### 4. Build the Flutter APK

```bash
cd flutter_application_mobile_project
flutter build apk --release
```

The APK will be generated at `build/app/outputs/flutter-apk/app-release.apk`.
Copy it to `builds/apk/app-release.apk`.

---

## Running the Tests

### 1. Start Appium Server

```bash
appium
```

The server will start on `http://localhost:4723` by default.

### 2. Start Android Emulator

```bash
emulator -avd <your_emulator_name>
```

Or connect a physical Android device via USB.

### 3. Run Authentication Test

```bash
cd appium_tests
python test_auth.py
```

### 4. Run Cart Test

```bash
cd appium_tests
python test_cart.py
```

**Note:** Run `test_auth.py` first to create a user account, then run `test_cart.py` while logged in.

---

## Test Configuration

If you need to modify the test configuration, update the following in each test file:

```python
options.device_name = "Android Emulator"  # Your device/emulator name
options.app = "./builds/apk/app-release.apk"  # Path to APK
```

### Finding Device Name

```bash
adb devices
```

---

## Test Files

| File | Description |
|------|-------------|
| `test_auth.py` | Authentication flow test (Signup → Login → Home) |
| `test_cart.py` | Cart flow test (Product → Add to Cart → Validate) |
| `test_cases.md` | Detailed test case documentation |
| `README.md` | This file |

---

## Troubleshooting

### Appium Server Not Starting
- Ensure Node.js is installed
- Run `appium driver install uiautomator2`

### Device Not Found
- Check `adb devices` output
- Restart ADB: `adb kill-server && adb start-server`

### Element Not Found
- Increase wait times in tests
- Verify element keys match the Flutter widget keys

### App Not Installing
- Ensure APK path is correct
- Check device has enough storage
- Verify APK is signed properly

---

## Expected Results

### Test 1: Authentication Flow
```
test_auth_flow (test_auth.TestAuthFlow) ... 
Step 1: Navigating to Signup screen...
Step 2: Filling Signup form...
Step 3: Logging in with created account...
Step 4: Verifying Home screen is displayed...
✅ Auth flow test PASSED!
ok
```

### Test 2: Cart Flow
```
test_cart_flow (test_cart.TestCartFlow) ... 
Step 1: Waiting for products to load...
Step 2: Opening first product...
Step 3: Adding product to cart...
Step 4: Navigating to cart...
Step 5: Validating item exists in cart...
✅ Cart flow test PASSED!
ok
```
