# Nicosia App - iOS MVP

A SwiftUI-based iOS application following MVVM architecture pattern.

## Project Structure

```
NicosiaApp/
├── Models/                 # Data models
├── Views/                  # SwiftUI views
│   ├── Components/         # Reusable UI components
│   └── Screens/           # App screens
├── ViewModels/            # View models (MVVM)
├── Services/              # Business logic and API services
│   ├── Network/           # Network layer
│   ├── Storage/           # Data persistence
│   └── Location/          # Location services
├── Utils/                 # Utility classes
│   ├── Constants/         # App constants
│   └── Helpers/          # Helper functions
├── Extensions/            # Swift extensions
└── Resources/             # Assets and localizations
    ├── Assets/
    └── Localizations/
```

## Architecture

This app follows the **MVVM (Model-View-ViewModel)** pattern:

- **Models**: Data structures and business entities
- **Views**: SwiftUI views that display the UI
- **ViewModels**: Manage UI state and business logic
- **Services**: Handle network requests, data persistence, and other services

## Key Features

- SwiftUI-based UI
- MVVM architecture
- Async/await for network operations
- Modular service layer
- Custom reusable components
- Comprehensive error handling

## Getting Started

1. Open the project in Xcode
2. Build and run the app
3. Start developing your features following the established patterns

## Development Guidelines

- Follow the existing MVVM pattern
- Use async/await for asynchronous operations
- Create reusable components in the Components folder
- Add new services in the Services folder
- Use the existing extensions for common functionality

## Dependencies

This project uses Swift Package Manager for dependency management. See `Package.swift` for available packages.