# Firebase Setup Guide - Laza E-commerce App

This guide explains how to set up Firebase for the Laza Flutter application.

---

## Prerequisites

- Google account
- Flutter SDK installed
- Firebase CLI installed (`npm install -g firebase-tools`)

---

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"**
3. Enter project name: `laza-ecommerce` (or your preferred name)
4. Disable Google Analytics (optional for this project)
5. Click **"Create project"**

---

## Step 2: Register Android App

1. In Firebase Console, click **"Add app"** → **Android**
2. Enter Android package name: `com.example.flutter_application_mobile_project`
   - Find this in `android/app/build.gradle` under `applicationId`
3. Enter app nickname: `Laza Android`
4. Click **"Register app"**
5. Download `google-services.json`
6. Place the file in `android/app/` directory

---

## Step 3: Register iOS App (Optional)

1. In Firebase Console, click **"Add app"** → **iOS**
2. Enter iOS bundle ID: `com.example.flutterApplicationMobileProject`
   - Find this in Xcode or `ios/Runner.xcodeproj/project.pbxproj`
3. Enter app nickname: `Laza iOS`
4. Click **"Register app"**
5. Download `GoogleService-Info.plist`
6. Place the file in `ios/Runner/` directory using Xcode

---

## Step 4: Enable Authentication

1. In Firebase Console, go to **"Authentication"**
2. Click **"Get started"**
3. Go to **"Sign-in method"** tab
4. Enable **"Email/Password"**
5. Click **"Save"**

---

## Step 5: Set Up Firestore Database

1. In Firebase Console, go to **"Firestore Database"**
2. Click **"Create database"**
3. Select **"Start in production mode"**
4. Choose a location closest to your users
5. Click **"Enable"**

---

## Step 6: Deploy Firestore Rules

1. Login to Firebase CLI:
   ```bash
   firebase login
   ```

2. Initialize Firebase in project:
   ```bash
   firebase init firestore
   ```

3. Deploy rules:
   ```bash
   firebase deploy --only firestore:rules
   ```

---

## Step 7: Configure Flutter Project

### Android Configuration

Edit `android/build.gradle`:
```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

Edit `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        minSdkVersion 21  // Required for Firebase
    }
}
```

### iOS Configuration

No additional configuration needed if `GoogleService-Info.plist` is properly added.

---

## Firestore Data Structure

```
firestore/
├── users/
│   └── {userId}/
│       ├── email: string
│       └── createdAt: timestamp
│
├── carts/
│   └── {userId}/
│       └── items/
│           └── {productId}/
│               ├── productId: number
│               ├── title: string
│               ├── price: number
│               ├── image: string
│               └── quantity: number
│
└── favorites/
    └── {userId}/
        └── items/
            └── {productId}/
                ├── productId: number
                ├── title: string
                ├── price: number
                ├── image: string
                └── addedAt: timestamp
```

---

## Security Rules

The `firestore.rules` file ensures:
- Users can only read/write their own data
- Authentication is required for all operations
- No unauthorized access to other users' data

---

## Troubleshooting

### "No Firebase App" Error
- Ensure `google-services.json` is in `android/app/`
- Run `flutter clean && flutter pub get`

### Authentication Errors
- Verify Email/Password sign-in is enabled
- Check Firebase project configuration

### Firestore Permission Denied
- Deploy the security rules: `firebase deploy --only firestore:rules`
- Verify user is authenticated before accessing data

---

## Testing Firebase Connection

Run the app and try to:
1. Create a new account
2. Login with the account
3. Add items to cart
4. Add items to favorites

If all operations succeed, Firebase is properly configured.
