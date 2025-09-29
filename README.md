# PokeDex Flutter App

A modern PokeDex application built with Flutter that allows users to browse, search, and favorite Pokémon. This app is designed for both Android and iOS, focusing on clean architecture and a robust user experience.

## Video


https://github.com/user-attachments/assets/f092da7c-aef7-4abc-9afb-3fe3b76a8499



## Features

- **Pokémon Grid**: Displays Pokémon with their official image, name, number, and a favorite button.
- **Infinite Scrolling**: Pokémon are loaded on demand for a smooth browsing experience.
- **Search**: Filter Pokémon by name.
- **Favorites View**: A dedicated tab shows all Pokémon marked as favorites.
- **Local Persistence**: Favorites are saved locally and persist across app sessions using `Hydrated BLoC`.
- **Detailed View**: A comprehensive detail screen showing:
  - Official artwork, name, and number
  - Height and weight
  - Types and abilities
  - Base stats (HP, Atk, etc.) visualized with progress bars
- **TODO: Full Evolution Chain**: Display the full evolution line for each Pokémon.
- **TODO: Advanced Sorting**: Sorting by stats and type is a planned feature.
- **TODO: Testing**: Unit and widget tests are planned for future development.

## Architecture & Technical Decisions

The project's architecture is organized into two main parts: the application module (`lib`) and a reusable local package (`packages/pokeapi`), promoting a clean separation of concerns.

- **App Module (`/lib`)**: Contains the presentation layer, including all UI (Widgets/Pages) and presentation logic (BLoCs).
- **PokeAPI Package (`/packages/pokeapi`)**: Encapsulates all data and domain logic. It acts as a self-contained data source for the application.

### Key Technical Decisions

- **State & Persistence (Hydrated BLoC)**: State management is handled by **BLoC**. To persist the user's favorites, **`hydrated_bloc`** was chosen. It's an extension of `flutter_bloc` that automatically saves the BLoC's state to the device, eliminating boilerplate code for local storage and simplifying state restoration.
- **Performance (API Data Fetching)**: The main Pokémon list does not display detailed stats. This is a deliberate trade-off because the list endpoint from the PokeAPI is basic. Fetching complete details for every item in the list would require hundreds of individual network requests, severely degrading performance.

## Getting Started

### Prerequisites

- Flutter SDK (version 3.x.x or higher)
- An IDE like VS Code or Android Studio

### Installation

1.  **Clone the repository:**
    ```sh
    git clone <your-repo-url>
    cd pokedex-flutter-app
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Run code generation:**
    This project uses `freezed`, which requires a code generation step.
    ```sh
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

### Running the App

Execute the following command to run the app on a connected device or emulator:
```sh
flutter run
