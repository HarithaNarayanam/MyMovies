# my_movies_app

A Flutter app that allows users to view a list of movies, mark them as favorites, and access the app both online and offline. This app fetches movie data from an online API and stores the favorites locally for offline access.


## Features

- View a list of movies.
- Mark movies as favorites.
- Store movies list locally for offline access.
- Sync movies list with online data when the app is online.
- Simple, clean UI to browse and manage movies.

- ## Getting Started

To run this app on your local machine, follow these steps:

### Prerequisites

Make sure you have code editor to run dart on your machine. 

You'll also need to have an emulator or a physical device to run the app.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/NarayanamHaritha/MyMovies.git


##Folder Structure 
lib/
├── features/              # Feature-specific modules (e.g., Movies, Authentication).
│      │         
│      ├── data/          # Data layer (Repositories, Data sources, Models).
│      │   ├── datasources/  # Local and remote data sources.
│      │   ├── models/       # Data models (e.g., Movie model).
│      │   └── repositories/ # Implementations of domain layer repositories.
│      ├── domain/        # Domain layer (Use cases, Entities, Repositories interfaces).
│      │   ├── entities/   # Core domain entities (e.g., Movie entity).
│      │   ├── repositories/ # Repository interfaces to be implemented in data layer.
│      │   └── usecases/   # Use case classes (business logic).
│      ├── presentation/  # Presentation layer (UI-related files like screens, widgets).
│      │   ├── bloc/cubit     # BLoC or State management classes (if using BLoC).
│      │   ├── screens/   # Flutter screens (e.g., Movie List screen).
│      │   └── widgets/   # UI components and widgets used across the feature.
│   
│
└── main.dart              # Entry point of the app.

   
