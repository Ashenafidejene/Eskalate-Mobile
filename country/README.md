# Countries Explorer

A Flutter application that displays country information from REST Countries API with search and favorites functionality.

## Features

- Browse all countries in grid/list view
- Search countries by name
- View detailed country information
- Add/remove favorites
- Dark/Light theme support
- Offline favorites storage

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
- IDE: Android Studio or VSCode with Flutter plugins

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Ashenafidejene/Eskalate-Mobile.git
   cd countries-explorer

### Architecture
The app follows Clean Architecture with:

Presentation Layer: UI components (Widgets, BLoCs)

Domain Layer: Business logic (Entities, Use Cases)

Data Layer: Data sources (API, Local Storage)

## State Management
Using BLoC pattern for:

Clear separation of concerns

Predictable state changes

Easy testing

Folder Structure

lib/
├── core/
│   ├── errors/     # Error handling
│   ├── network/    # API communication
│   ├── theme/      # App theming
│   └── utils/      # Utilities
│
├── features/
│   └── country_search/
│       ├── data/       # Data sources & models
│       ├── domain/     # Business logic
│       └── presentation/ # UI components
│
├── injection_container.dart # Dependency setup
└── main.dart          # App entry point

### Dependencies
Main packages used:

flutter_bloc: State management

http: API calls

shared_preferences: Local storage

connectivity_plus: Network status

loading_animation_widget: Loading animations