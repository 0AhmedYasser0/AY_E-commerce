# Laza - E-commerce Mobile App

A Flutter-based e-commerce mobile application for Android and iOS platforms.

## Project Overview

**Laza** is a fully functional e-commerce MVP application built with Flutter and Firebase. It features user authentication, product browsing, cart management, favorites, and checkout functionality.

## Features

- **Authentication**
  - Email/Password Signup
  - Email/Password Login
  - Password Reset
  - Auto-login (persistent sessions)

- **Products**
  - Browse products from Platzi Fake Store API
  - Local search filter
  - Product detail view

- **Cart**
  - Add/Remove items
  - Update quantities
  - Subtotal calculation
  - Checkout with confirmation

- **Favorites**
  - Add/Remove favorites
  - Persistent storage in Firestore

- **Profile**
  - View user email
  - Logout functionality

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Flutter 3.x |
| Language | Dart |
| Backend | Firebase (Auth + Firestore) |
| API | Platzi Fake Store API |
| State Management | Provider |

## Project Structure

```
/lib
  /models          # Data models (Product, CartItem)
  /providers       # State management (Auth, Cart, Favorites, Products)
  /screens         # UI screens
  /services        # API and Firebase services
  main.dart        # App entry point
/assets            # Static assets
/test              # Unit tests
/appium_tests      # Appium E2E tests
/docs              # Documentation
  /screenshots     # App screenshots
  /results         # Test results
/builds
  /apk             # Android APK builds
  /ios_instructions # iOS build instructions
/video             # Demo videos
```

## Getting Started

### Prerequisites

- Flutter SDK 3.x
- Dart SDK
- Android Studio / Xcode
- Firebase account

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter_application_mobile_project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Follow instructions in `docs/firebase_setup.md`
   - Add `google-services.json` to `android/app/`
   - Add `GoogleService-Info.plist` to `ios/Runner/`

4. **Run the app**
   ```bash
   flutter run
   ```

### Building APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

## Firebase Configuration

See `docs/firebase_setup.md` for detailed Firebase setup instructions.

### Firestore Collections

| Collection | Description |
|------------|-------------|
| `users` | User profiles |
| `carts` | User shopping carts |
| `favorites` | User favorite items |

### Security Rules

Deploy Firestore rules:
```bash
firebase deploy --only firestore:rules
```

## API Reference

**Base URL:** `https://api.escuelajs.co/api/v1`

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/products` | GET | Get all products |
| `/products/{id}` | GET | Get product by ID |

## Testing

### Appium E2E Tests

Located in `/appium_tests`:

1. **Authentication Test** (`test_auth.py`)
   - Flow: Signup → Login → Home

2. **Cart Test** (`test_cart.py`)
   - Flow: Product → Add to Cart → Validate

**Running Tests:**
```bash
# Start Appium server
appium

# Run tests
python appium_tests/test_auth.py
python appium_tests/test_cart.py
```

See `appium_tests/README.md` for detailed instructions.

## Documentation

| Document | Location |
|----------|----------|
| Firebase Setup | `docs/firebase_setup.md` |
| Test Cases | `docs/test_cases.md` |
| Test Summary | `docs/test_summary.md` |
| Firestore Rules | `firestore.rules` |

## Screenshots

Screenshots are stored in `docs/screenshots/`.

## License

This project is for academic purposes only.

## Author

Student Project - Mobile Application Development Course
