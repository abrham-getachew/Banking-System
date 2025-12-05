# Banking System

I am developing a modern, AI‑integrated mobile banking system using Flutter for the frontend and Node.js for backend services. The goal is to build a secure, scalable, and user‑friendly digital banking experience with modern UI/UX and intelligent automation.

# Flutter Application

A modern Flutter-based mobile application utilizing the latest mobile development technologies and tools for building responsive cross‑platform applications.

## 📋 Prerequisites
- Flutter SDK (^3.29.2)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Android SDK / Xcode (for iOS development)

## 🛠️ Installation
1. Install dependencies:
   flutter pub get

2. Run the application:
   flutter run

## 📁 Project Structure
flutter_app/
├── android/               # Android-specific configuration
├── ios/                   # iOS-specific configuration
├── lib/
│   ├── core/              # Core utilities and services
│   │   └── utils/         # Utility classes
│   ├── presentation/      # UI screens and widgets
│   │   └── splash_screen/ # Splash screen implementation
│   ├── routes/            # Application routing
│   ├── theme/             # Theme configuration
│   ├── widgets/           # Reusable UI components
│   └── main.dart          # Application entry point
├── assets/                # Static assets (images, fonts, etc.)
├── pubspec.yaml           # Project dependencies and configuration
└── README.md              # Project documentation

## 🧩 Adding Routes
Update `lib/routes/app_routes.dart`:

import 'package:flutter/material.dart';
import 'package:package_name/presentation/home_screen/home_screen.dart';

class AppRoutes {
static const String initial = '/';
static const String home = '/home';

static Map<String, WidgetBuilder> routes = {
initial: (context) => const SplashScreen(),
home: (context) => const HomeScreen(),
};
}

## 🎨 Theming
ThemeData theme = Theme.of(context);
Color primaryColor = theme.colorScheme.primary;

Includes:
- Light & dark color schemes
- Typography styles
- Button themes
- Input decoration themes
- Card & dialog themes

## 📱 Responsive Design
Using the Sizer package:

Container(
width: 50.w,
height: 20.h,
child: Text('Responsive Container'),
);

## 📦 Deployment
# Android
flutter build apk --release

# iOS
flutter build ios --release

## 🙏 Acknowledgments
- Built with Rocket.new
- Powered by Flutter & Dart
- Styled with Material Design

Built with ❤️ on Rocket.new
