# Betalent Employees App

A Flutter application for managing employee information. This app demonstrates clean architecture principles and follows Flutter best practices.

## About the Project

This mobile application is built using Flutter and implements:
- Clean Architecture principles
- HTTP client for API communication
- Material Design with custom theming
- Employee management functionality
- Search and filter capabilities
- Responsive design for both iOS and Android

## Features

- View list of employees
- Search employees by name, job, or phone number
- Detailed employee information display
- Custom UI components
- Error handling and loading states
- Notification system (Badge) Mocked

## Prerequisites

Before running the application, ensure you have the following installed:
- Flutter SDK (^3.7.0)
- Dart SDK
- Android Studio / Xcode (for emulators)
- Git

## Dependencies

The project uses the following key dependencies:

http: ^1.1.0 # For API communication

dartz: ^0.10.1 # For functional programming features

intl: ^0.20.2 # For internationalization and formatting

## Getting Started

1. **Clone the Repository**
```bash
git clone https://github.com/PedroHMacedo/betalent_employees_app.git
cd betalent_employees_app
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Run the Application**

Before running the application, you need to configure the API URL in `lib/data/repositories/employee_repository_impl.dart`:

- For Android Emulator: Use `10.0.2.2:3000` (Android's localhost equivalent)
- For iOS Simulator: Use `localhost:3000`
- For Physical Device: Use your computer's IPv4 address (e.g., `192.168.1.100:3000`)

You can find your IPv4 address by:
- Windows: Run `ipconfig` in Command Prompt
- macOS/Linux: Run `ifconfig` or `ip addr` in Terminal

Make sure you have an emulator running or a physical device connected, then:

## Project Structure

```
lib/
├── core/
│   ├── error/
│   └── http_client/
├── data/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── controllers/
│   ├── pages/
│   └── widgets/
├── theme/
│   ├── app_theme.dart
│   ├── colors.dart
│   └── text_styles.dart
└── main.dart
```

## Building for Release

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Architecture

The project follows Clean Architecture principles with three main layers:
- **Domain Layer**: Contains business logic and use cases.
- **Data Layer**: Handles data operations and repository implementations.
- **Presentation Layer**: Manages UI components and state.

## I also uploaded a video file with the name employees_app.mp4 to view the application without having to clone the repository and run it.
