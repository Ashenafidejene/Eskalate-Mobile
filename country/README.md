# Countries Explorer

A Flutter application for exploring country information using the REST Countries API. Features include search, favorites, and offline support.

## Features

- Browse countries in grid or list view
- Search countries by name
- View detailed country information
- Add or remove favorites
- Dark and light theme support
- Offline storage for favorites

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK (bundled with Flutter)
- IDE: Android Studio or VS Code with Flutter plugins

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/Ashenafidejene/Eskalate-Mobile.git
    cd Eskalate-Mobile/country
    ```

2. Get dependencies:
    ```bash
    flutter pub get
    ```

3. Run the app:
    ```bash
    flutter run
    ```

## Architecture

The app uses Clean Architecture, organized into:

- **Presentation Layer:** UI widgets and BLoCs
- **Domain Layer:** Entities and use cases
- **Data Layer:** API and local storage sources

## State Management

BLoC pattern is used for:

- Separation of concerns
- Predictable state changes
- Easier testing

### Folder Structure

```
lib/
├── core/
│   ├── errors/         # Error handling
│   ├── network/        # API communication
│   ├── theme/          # App theming
│   └── utils/          # Utilities
│
├── features/
│   └── country_search/
│       ├── data/           # Data sources & models
│       ├── domain/         # Business logic
│       └── presentation/   # UI components
│
├── injection_container.dart # Dependency setup
└── main.dart                # App entry point
```

### Dependencies

Key packages:

- `flutter_bloc`: State management
- `http`: API requests
- `shared_preferences`: Local storage
- `connectivity_plus`: Network status
- `loading_animation_widget`: Loading animations