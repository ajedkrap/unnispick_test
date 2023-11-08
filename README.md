# Unnispick Test

This repository is intended to fulfill the test provided by Kotra / Unnispick

## How to Use 

**Step 1: Clone the Project**

Download or clone this repo by using the link below:

```
https://github.com/ajedkrap/unnispick_test.git
```

**Step 2: Install Flutter Dependenscies**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3: Clean Build Project**

Clean the project build to each native platform: 

```
- Android: cd android && ./gradlew clean && cd ..
- iOS: cd ios && pod install && cd ..
```

**Step 4: Run Application**


Make sure check which platform is available by run `flutter devices`.

For Android emulator, configuration available at AVD section in Android Studio.\
For iOS simulator, configutation available in Xcode.

Run the application to desired platform:

```
flutter run
```

Download Apk: [unnispick_test-v1.0.0.apk](https://drive.google.com/file/d/1CBRTGDVE24oA6hN_qwl9Mx7UJtVsW5IY/view?usp=drive_link)


UI inspired from [Mobile Authentication by Cosmin Ferecatu](https://dribbble.com/shots/17675798-Mobile-authentication/attachments/12832987?mode=media)
