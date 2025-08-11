# CoinRankingiOSApp

Overview
This iOS application fetches cryptocurrency data from the CoinRanking API and provides a rich user experience including:

Splash screen, Get Started onboarding, and Login screens

List of top 100 coins with pagination and filtering

Swipe left to favorite/unfavorite coins

Detailed coin views with performance charts and filters

Favorites screen listing all saved coins

Support for both Light Mode and Dark Mode

Tech Stack
Language: Swift 5+

UI Frameworks:

UIKit for main views (lists, navigation, interactions)

SwiftUI for modular views (onboarding screens, charts, detail components)

Networking: RxAlamofire for reactive REST API requests

Reactive Programming: RxSwift for async data streams and bindings

Layout: SnapKit for programmatic UI constraints in UIKit views

Charts: DGCharts for displaying coin performance graphs

Persistence:

UserDefaults for simple local storage (favorites, UUIDs)

Keychain used alongside config files to securely store the API key at runtime

Dependency Injection: Applied for modularity and ease of testing

Features & Flow
Splash & Onboarding: Animated splash and multi-step Get Started screens using SwiftUI

Login: Basic login implemented with sanity checks; currently accepts any input (Firebase OTP validation planned)

Top 100 Coins List:

Pagination with 20 coins per page

Sorting/filtering by price and 24-hour performance

Swipe-to-favorite coins

Coin Details: Performance chart with selectable time filters and detailed statistics

Favorites Screen: View and manage favorite coins with swipe-to-unfavorite support

Dark Mode: Full support following system appearance settings

Known Limitations
Firebase OTP validation for login is not yet integrated due to time constraints; current login performs basic sanity checks only

No offline caching or advanced local persistence beyond UserDefaults

Error handling on login and network failures could be improved

Build & Run Instructions
Clone the repo:
git clone https://github.com/yourusername/CoinRankingCrypto.git

Open CoinRankingCrypto.xcodeproj in Xcode

Install dependencies via CocoaPods or Swift Package Manager

Build and run on iOS 14+ simulator or physical device

Testing
Unit tests cover repository and domain layers using mocks and RxBlocking

Tests verify pagination, filtering, and local favorites persistence

UI tests are not currently implemented

Security & Configuration
API key stored securely using:

Configuration files (.xcconfig) for build-time management

Keychain at runtime to protect sensitive keys from exposure

Network requests use HTTPS through RxAlamofire

Sensitive user data stored only in UserDefaults for non-critical data (favorites)

No SSL pinning or biometric authentication implemented yet

No custom binary hardening like stack canaries or code obfuscation currently

Challenges & Solutions
Managing a hybrid UIKit + SwiftUI UI and reactive state synchronization

Handling multiple loading states (initial, pull-to-refresh, pagination) cleanly with RxSwift

Implementing adaptive dark and light mode styles

Limited time prevented full Firebase OTP integration

Future Improvements
Implement Firebase OTP validation for login security

Add DexGuard for code obfuscation and binary protection

Integrate Dynatrace monitoring for performance and crash analytics

Use Keychain/Secure Enclave for sensitive user data storage beyond API keys

Add offline caching and background data refresh

Expand test coverage with UI and integration tests

Implement SSL pinning and biometric authentication for enhanced security

License
MIT License
