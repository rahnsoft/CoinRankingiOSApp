# CoinRankingCrypto iOS App

## Overview

This iOS application fetches cryptocurrency data from the CoinRanking API and provides a rich user experience including:

- Splash screen, Get Started onboarding, and Login screens  
- List of top 100 coins with pagination and filtering  
- Swipe left to favorite/unfavorite coins  
- Detailed coin views with performance charts and filters  
- Favorites screen listing all saved coins  
- Support for both Light Mode and Dark Mode  

## Tech Stack

- **Language:** Swift 5+  
- **UI Frameworks:**  
  - UIKit for main views (lists, navigation, interactions)  
  - SwiftUI for modular views (onboarding screens, charts, detail components)  
- **Networking:** RxAlamofire for reactive REST API requests  
- **Reactive Programming:** RxSwift for async data streams and bindings  
- **Layout:** SnapKit for programmatic UI constraints in UIKit views  
- **Charts:** DGCharts for displaying coin performance graphs  
- **Persistence:**  
  - UserDefaults for simple local storage (favorites, UUIDs)  
  - Keychain used alongside config files to securely store the API key at runtime  
- **Dependency Injection:** Applied for modularity and ease of testing  

## Architecture

This project follows a **MVVM + Coordinator (MVVM+C)** pattern combined with **Clean Architecture** principles to ensure a scalable, maintainable, and testable codebase.

- **MVVM (Model-View-ViewModel):**  
  Separates UI logic from business logic, enabling clear data binding and reactive updates. This improves code clarity and testability—crucial for handling real-time data in a fintech environment.

- **Coordinator Pattern:**  
  Manages navigation and flow logic outside of view controllers, keeping the UI components lightweight and focused on their presentation responsibilities. This makes onboarding, login, and complex screen flows easier to manage and extend.

- **Clean Architecture:**  
  Enforces separation of concerns between domain, data, and presentation layers. This promotes modularity and flexibility, allowing independent development and testing of core business rules, which is vital for the security and reliability required in financial apps.

**Why this architecture for a fintech app?**  
Financial applications demand high reliability, security, and maintainability. By structuring the codebase with MVVM+C and Clean Architecture, we achieve:  
- **Robustness:** Clear boundaries reduce bugs and unintended side-effects.  
- **Testability:** Domain logic can be thoroughly unit tested without UI dependencies.  
- **Scalability:** Easy to add features like new screens, authentication flows, or external services.  
- **Maintainability:** Code is easier to understand and modify, which is critical for evolving fintech requirements.

## Features & Flow

- Splash & Onboarding: Animated splash and multi-step Get Started screens using SwiftUI  
- Login: Basic login implemented with sanity checks; currently accepts any input (Firebase OTP validation planned)  
- Top 100 Coins List:  
  - Pagination with 20 coins per page  
  - Sorting/filtering by price and 24-hour performance  
  - Swipe-to-favorite coins  
- Coin Details: Performance chart with selectable time filters and detailed statistics  
- Favorites Screen: View and manage favorite coins with swipe-to-unfavorite support  
- Dark Mode: Full support following system appearance settings  

## Known Limitations

- Firebase OTP validation for login is not yet integrated due to time constraints; current login performs basic sanity checks only  
- No offline caching or advanced local persistence beyond UserDefaults  
- Error handling on login and network failures could be improved  

## Build & Run Instructions

1. Clone the repo:  
   ```bash
   git clone https://github.com/rahnsoft/CoinRankingiOSApp.git
   pod install
