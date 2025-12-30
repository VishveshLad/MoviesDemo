# 🎬 Movies Demo -- SwiftUI (Production Ready)

A **production-grade SwiftUI Movies application** demonstrating modern
iOS architecture using **MVVM**, **async/await**, **Dependency
Injection**, and **centralized navigation**.

The app fetches real-time movie/show data from a **free public API** and
displays: - Movies list with images - Movie details screen - Proper
loading, empty, and error states

------------------------------------------------------------------------

## 🚀 Tech Stack

-   SwiftUI
-   MVVM Architecture
-   Async / Await
-   URLSession
-   Dependency Injection (DI)
-   Centralized Navigation (Router)
-   iOS 16+ NavigationStack

------------------------------------------------------------------------

## 🌐 API Used (Free & No API Key)

**TVMaze API**

  Purpose        Endpoint
  -------------- -----------------------------------
  Movies list    https://api.tvmaze.com/shows
  Movie detail   https://api.tvmaze.com/shows/{id}

✔ No authentication\
✔ Stable & production-safe\
✔ Includes images

------------------------------------------------------------------------

## 📂 Folder Structure

    MoviesDemo/
    ├─ App/
    │  └─ MoviesDemoApp.swift
    ├─ DI/
    │  └─ AppContainer.swift
    ├─ Scenes/
    │  ├─ MoviesList/
    │  │  ├─ MoviesListView.swift
    │  │  └─ MoviesListViewModel.swift
    │  └─ MovieDetail/
    │     ├─ MovieDetailView.swift
    │     └─ MovieDetailViewModel.swift
    ├─ Shared/
    │  ├─ Models/
    │  │  └─ Movie.swift
    │  ├─ Networking/
    │  │  ├─ APIEndpoints.swift
    │  │  ├─ NetworkClient.swift
    │  │  └─ NetworkError.swift
    │  ├─ Services/
    │  │  ├─ MovieServiceProtocol.swift
    │  │  └─ MovieService.swift
    │  └─ Navigation/
    │     └─ Router.swift

------------------------------------------------------------------------

## 🧠 Architecture Overview

### MVVM

-   **View** → SwiftUI UI
-   **ViewModel** → Business logic & state
-   **Model** → API response models

### Dependency Injection

-   All dependencies are created in `AppContainer`
-   No direct dependency creation inside views
-   Easy to mock and test

### Centralized Navigation

-   Single `Router`
-   Uses `NavigationStack` + `NavigationPath`
-   Navigation logic separated from UI

------------------------------------------------------------------------

## 🔄 State Management

Each ViewModel uses a single source of truth:

``` swift
enum ViewState {
    case idle
    case loading
    case empty
    case loaded(Data)
    case error(String)
}
```

------------------------------------------------------------------------

## 🛠 Requirements

-   Xcode 15+
-   iOS 16+
-   Swift 5.9+

------------------------------------------------------------------------

## ▶️ How to Run

1.  Clone the repository
2.  Open `MoviesDemo.xcodeproj`
3.  Run on iOS Simulator

------------------------------------------------------------------------

## 📈 Future Enhancements

-   Search
-   Pagination
-   Favorites
-   Offline cache
-   Unit tests
-   Deep linking

------------------------------------------------------------------------

## 👨‍💻 Author

**Vishvesh Lad**\
iOS Developer -- SwiftUI & MVVM

------------------------------------------------------------------------

## 📄 License

This project is for learning and demonstration purposes.
