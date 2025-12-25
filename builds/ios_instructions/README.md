# iOS Build Instructions

## Prerequisites

- macOS with Xcode installed
- Apple Developer account (for device deployment)
- CocoaPods installed

## Setup

1. **Install CocoaPods dependencies**
   ```bash
   cd ios
   pod install
   ```

2. **Add Firebase configuration**
   - Download `GoogleService-Info.plist` from Firebase Console
   - Add to `ios/Runner/` using Xcode

3. **Open in Xcode**
   ```bash
   open ios/Runner.xcworkspace
   ```

## Building

### Debug Build
```bash
flutter build ios --debug
```

### Release Build
```bash
flutter build ios --release
```

## Running on Simulator
```bash
flutter run -d <simulator_id>
```

## Running on Device

1. Connect iOS device
2. Trust the computer on device
3. Select device in Xcode
4. Run: `flutter run`

## Archive for App Store

1. Open `Runner.xcworkspace` in Xcode
2. Select "Any iOS Device" as target
3. Product → Archive
4. Distribute App

## Troubleshooting

### Pod Install Fails
```bash
cd ios
pod deintegrate
pod install
```

### Signing Issues
- Open Xcode
- Select Runner target
- Signing & Capabilities
- Select your team

### Build Errors
```bash
flutter clean
flutter pub get
cd ios && pod install
```
