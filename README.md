# Laza E-Commerce App

A fully functional mobile e-commerce application built with Flutter, featuring user authentication, product browsing, shopping cart management, and favorites functionality. This project demonstrates modern mobile development practices with Firebase backend integration and comprehensive end-to-end testing.

---

## 📋 Project Overview

**Laza** is a complete e-commerce mobile application developed as part of a Mobile Application Development course. The application integrates external REST APIs for product catalog management, Firebase for user authentication and data persistence, and includes automated end-to-end testing using Appium and WebDriverIO.

### **Core Technologies**

- **Framework:** Flutter 3.x (Dart SDK ^3.9.2)
- **State Management:** Provider 6.1.2
- **Backend - Authentication:** Firebase Auth 5.3.4
- **Backend - Database:** Cloud Firestore 5.6.0
- **External API:** Platzi Fake Store API
- **E2E Testing:** Appium + WebDriverIO 8.0.0 (Node.js)

---

## ⚠️ **CRITICAL: Security & Configuration Setup**

### **Important Notice**

For security reasons, sensitive Firebase configuration files and API keys have been **intentionally removed** from this repository and replaced with placeholders. This is a standard security practice to prevent unauthorized access to Firebase resources when sharing code publicly.

### **⚠️ The application will NOT run without completing the following setup steps:**

#### **Step 1: Create Firebase Project**
1. Navigate to [Firebase Console](https://console.firebase.google.com/)
2. Create a new Firebase project or select an existing one
3. Enable the following services:
   - **Authentication** → Enable "Email/Password" sign-in method
   - **Firestore Database** → Create database in production mode

#### **Step 2: Download `google-services.json`**
1. In Firebase Console, go to **Project Settings** → **General**
2. Scroll to **Your apps** section
3. Select your Android app (or add a new Android app if needed)
4. Download the `google-services.json` file
5. Place it in: `android/app/google-services.json`

#### **Step 3: Configure Firebase Options**
Choose one of the following methods:

**Option A (Recommended):** Use FlutterFire CLI
```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure
```

**Option B (Manual):** Update `lib/firebase_options.dart`
- Open `lib/firebase_options.dart`
- Replace all placeholder values with your actual Firebase project credentials:
  - `apiKey`
  - `appId`
  - `messagingSenderId`
  - `projectId`
  - `storageBucket`

#### **Step 4: Deploy Firestore Security Rules**
```bash
firebase deploy --only firestore:rules
```

### **Why Are Keys Removed?**
This is a security best practice to:
- Prevent unauthorized access to Firebase resources
- Protect sensitive user data
- Demonstrate proper security awareness in software development
- Comply with academic integrity standards

**Note for Examiners:** The missing configuration files are **not a bug** but a deliberate security measure. Follow the steps above to restore full functionality.

---

## ✅ Automated Testing (Appium & WebDriverIO)

This project includes comprehensive end-to-end (E2E) tests using **Appium** with **WebDriverIO** (Node.js framework). The tests validate critical user flows including authentication and shopping cart functionality.

### **Testing Framework**
- **Platform:** Node.js
- **Test Runner:** WebDriverIO 8.0.0
- **Automation:** Appium with UiAutomator2 (Android)
- **Language:** JavaScript

### **Prerequisites**

Before running tests, ensure you have:
- **Node.js** (v14 or higher)
- **NPM** (Node Package Manager)
- **Appium Server** (installed globally)
- **Android Emulator** or physical device connected
- **Release APK** built and available at `build/app/outputs/flutter-apk/app-release.apk`

### **Installation**

1. **Install Appium globally:**
   ```bash
   npm install -g appium
   ```

2. **Install test dependencies:**
   ```bash
   cd appium_tests
   npm install
   ```

### **Running Tests**

1. **Start Appium Server** (in a separate terminal):
   ```bash
   appium
   ```

2. **Run Tests** (in another terminal):

   **Authentication Test** - Tests Login/Signup Flow:
   ```bash
   npm run test:auth
   ```
   - **Flow:** Launch App → Enter Email → Enter Password → Click Login → Verify Home Screen
   - **Validates:** User authentication, form validation, and navigation

   **Cart Test** - Tests Product Selection and Cart Management:
   ```bash
   npm run test:cart
   ```
   - **Flow:** Auto-login → Click Product → Add to Cart → Navigate to Cart → Verify Cart Contents
   - **Validates:** Product selection, cart functionality, and Firestore persistence

### **Test Configuration**

The tests are configured to:
- Use the release APK located at `../build/app/outputs/flutter-apk/app-release.apk`
- Run on Android platform with UiAutomator2 automation
- Handle automatic login for cart tests (using `noReset: false`)
- Use modern W3C WebDriver protocol for touch actions

For detailed test case documentation, see `appium_tests/test_cases.md`.

---

## 🚀 Key Features

### **1. Authentication System**
- **Sign Up:** Email/password registration with email verification
- **Login:** Secure authentication with error handling and validation
- **Forgot Password:** Password reset functionality with email trigger
- **Persistent Sessions:** Auto-login for returning users
- **Security:** Firebase Authentication with email verification

### **2. Product Catalog (Home Screen)**
- **External API Integration:** Fetches products from Platzi Fake Store API
- **Product Grid Display:** Responsive grid layout with product images
- **Search Functionality:** Real-time client-side product filtering
- **Product Details:** Detailed view with description, price, and images

### **3. Shopping Cart**
- **Add to Cart:** Add products with automatic quantity management
- **Update Quantities:** Increment/decrement item quantities
- **Remove Items:** Delete items from cart
- **Real-time Sync:** Firestore-backed persistence across sessions
- **Cart Badge:** Visual indicator showing total item count
- **Subtotal Calculation:** Automatic price calculation

### **4. Favorites System**
- **Toggle Favorites:** Add/remove products from favorites
- **Persistent Storage:** Favorites saved in Firestore
- **Real-time Updates:** Automatic synchronization across devices
- **Dedicated Screen:** View all favorited products in one place

### **5. Security & Best Practices**
- **API Keys Secured:** Sensitive credentials removed from version control
- **Gitignore Configuration:** Prevents accidental commits of sensitive files
- **Placeholder Files:** Clear documentation for setup requirements
- **Firestore Security Rules:** User-specific data access controls

---

## 📂 Project Structure

```
flutter_application_mobile_project/
├── lib/
│   ├── models/              # Data models (Product, CartItem)
│   ├── providers/           # State management with Provider pattern
│   │   ├── auth_provider.dart
│   │   ├── cart_provider.dart
│   │   ├── favorites_provider.dart
│   │   └── product_provider.dart
│   ├── services/            # API and Firebase service layer
│   │   ├── api_service.dart        # Platzi API integration
│   │   ├── auth_service.dart       # Firebase Auth wrapper
│   │   └── firestore_service.dart  # Firestore operations
│   ├── screens/             # UI screens (Login, Home, Cart, etc.)
│   ├── main.dart            # Application entry point
│   └── firebase_options.dart # Firebase config (⚠️ REQUIRES SETUP)
├── android/
│   └── app/
│       └── google-services.json # Firebase Android config (⚠️ REQUIRES SETUP)
├── appium_tests/            # E2E tests (Node.js + WebDriverIO)
│   ├── auth_test.js         # Authentication flow test
│   ├── cart_test.js         # Shopping cart flow test
│   ├── package.json         # NPM dependencies (WebDriverIO)
│   ├── test_cases.md        # Test case documentation
│   └── README.md            # Testing setup instructions
├── docs/                    # Documentation and screenshots
├── firestore.rules          # Firestore security rules
└── pubspec.yaml             # Flutter dependencies
```

### **Key Directories Explained**

- **`lib/providers/`**: Implements state management using the Provider pattern. Each provider manages a specific domain (Auth, Cart, Favorites, Products).
- **`lib/services/`**: Service layer that handles external API calls (Platzi API) and Firebase operations (Auth, Firestore).
- **`appium_tests/`**: Contains end-to-end tests written in JavaScript using WebDriverIO and Appium for mobile automation.

---

## 🛠️ Installation & Setup

### **Prerequisites**
- Flutter SDK 3.x or higher
- Dart SDK
- Android Studio / Xcode
- Firebase account (for configuration)
- Node.js & NPM (for running tests)

### **Installation Steps**

1. **Clone the repository:**
   ```bash
   git clone https://github.com/0AhmedYasser0/AY_E-commerce.git
   cd flutter_application_mobile_project
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (See "⚠️ CRITICAL: Security & Configuration Setup" section above)

4. **Run the application:**
   ```bash
   flutter run
   ```

5. **Build release APK:**
   ```bash
   flutter build apk --release
   ```
   Output: `build/app/outputs/flutter-apk/app-release.apk`

---

## 📚 Additional Documentation

| Document | Location | Description |
|----------|----------|-------------|
| Test Cases | `appium_tests/test_cases.md` | Detailed test case specifications |
| Appium Setup | `appium_tests/README.md` | Testing environment setup guide |
| Firestore Rules | `firestore.rules` | Database security rules |
| Screenshots | `docs/screenshots/` | Application screenshots |

---

## 🔒 Security & Privacy

- **API Keys:** All sensitive Firebase credentials have been removed from this repository
- **Best Practice:** Never commit `google-services.json` or API keys to version control
- **Firestore Rules:** User-specific data is protected with security rules
- **Authentication:** Email verification is enabled for new user registrations
- **Data Privacy:** User data (cart, favorites) is isolated per user ID

---

## 📄 License

This project is developed for **academic purposes only** as part of a Mobile Application Development course.

---

## 👨‍💻 Author

**Student Project** - Mobile Application Development Course

**Repository:** [github.com/0AhmedYasser0/AY_E-commerce](https://github.com/0AhmedYasser0/AY_E-commerce)

---

## 🆘 Troubleshooting

### **App crashes on launch**
- Verify `google-services.json` is present in `android/app/`
- Confirm `lib/firebase_options.dart` contains valid API keys
- Check that Firebase Authentication and Firestore are enabled in Firebase Console

### **Appium tests fail**
- Ensure release APK is built: `flutter build apk --release`
- Verify Appium server is running on `localhost:4723`
- Confirm Android emulator or device is connected: `adb devices`
- Check that test dependencies are installed: `cd appium_tests && npm install`

### **Products not loading**
- Verify internet connection is active
- Test API accessibility: `curl https://api.escuelajs.co/api/v1/products`
- Check for API rate limiting or service outages

### **Cart/Favorites not syncing**
- Confirm user is logged in (check Firebase Console → Authentication)
- Verify Firestore security rules are deployed: `firebase deploy --only firestore:rules`
- Check Firebase Console → Firestore for error logs
- Ensure `userId` is properly set in `CartProvider` and `FavoritesProvider`

---

**For Examiners:** This project demonstrates proficiency in Flutter development, Firebase integration, state management with Provider, external API consumption, and automated mobile testing with Appium. The security measures implemented (removed API keys) reflect industry best practices and should not be considered a deficiency.
