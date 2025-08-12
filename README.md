# 💰 CoinRankingCrypto iOS App

## 📖 Overview

An iOS application that fetches cryptocurrency data from the **CoinRanking API** and delivers a rich, secure, and responsive user experience.

### ✨ Highlights
- 🖼 **Splash Screen & Onboarding** — Smooth SwiftUI transitions  
- 📋 **Top 100 Coins List** — Pagination, sorting, and filtering  
- ⭐ **Favorites Management** — Swipe to favorite/unfavorite coins  
- 📈 **Detailed Coin View** — Price history charts and statistics  
- 🌙 **Dark & Light Mode** — Full system appearance support  

---

## 🛠 Tech Stack

- **Language:** Swift 5+  
- **UI Frameworks:**  
  - UIKit for main lists, navigation, and interactions  
  - SwiftUI for onboarding, charts, and modular components  
- **Architecture:**  
  - **MVVM + Coordinator (MVVM+C)** combined with **Clean Architecture**  
  - MVVM for separation of concerns and reactive data binding  
  - Coordinators for navigation flow control  
  - Clean Architecture for strict separation between presentation, domain, and data layers  
- **Networking:**  
  - Alamofire with **SSL Pinning**  
  - All API calls over HTTPS with enforced TLS  
  - Combine for reactive streams  
- **Reactive Programming:** Combine for data binding & state updates  
- **Layout:** SnapKit for programmatic constraints in UIKit  
- **Charts:** DGCharts for historical price data visualization  
- **Persistence:**  
  - `UserDefaults` for non-sensitive data (favorites UUIDs)  
  - Keychain for secure API key storage  
- **Compiler Hardening:**  
  - `-fstack-protector-all` flag for stack canaries (verified with `otool`)  
- **Dependency Management:**  
  - **Mix of Swift Package Manager (SPM) & CocoaPods**  
  - **Why?**  
    - 📦 **SPM** for lightweight, actively maintained libraries with native Xcode integration  
    - 🔧 **CocoaPods** for packages lacking robust SPM support or needing custom build configurations  
    - 🔄 Hybrid approach ensures **maximum compatibility, flexibility, and stability**  

---

## 🏗 Architecture

This app follows **MVVM + Coordinator** with **Clean Architecture** principles.

**Why this matters for fintech apps:**
- 🛡 **Robustness:** Prevents accidental coupling & unintended side effects  
- 🧪 **Testability:** Core business rules can be tested without UI dependencies  
- 📈 **Scalability:** Add features or new data sources without breaking existing ones  
- 🛠 **Maintainability:** Modular design makes updates safer and faster  

**Structure:**
- **Domain Layer:** Use cases, business rules, and core entities  
- **Data Layer:** Networking clients, repositories, and persistence adapters  
- **Presentation Layer:** UIKit/SwiftUI views, ViewModels, and Coordinators  

---

## 🔒 Security Considerations

Security is critical in fintech and cryptocurrency apps. This project implements:

- **🔑 API Key Protection:**  
  - API key securely stored in **Keychain**  
  - Loaded at runtime from a configuration file excluded from version control  

- **🛡 SSL Pinning:**  
  - Alamofire ensures communication only with trusted CoinRanking servers  
  - Mitigates man-in-the-middle (MITM) attacks  

- **🔐 Compiler Hardening:**  
  - `-fstack-protector-all` enabled to insert stack canaries into **all functions**  
  - Verified with:
    ```bash
    otool -Iv AppName | grep stack
    ```

- **📦 Minimal Local Storage:**  
  - Only non-sensitive UUIDs for favorites are stored in `UserDefaults`  
  - No tokens, private keys, or personal data stored locally  

**Recommended for production:**
- 🛡 **DexGuard** — Code/resource obfuscation to prevent reverse engineering  
- 📊 **Dynatrace** — Real-time performance and anomaly monitoring  
- 🔒 **Encrypted Offline Caching** — Secure local data storage  
- 👤 **Biometric Authentication** — Face ID/Touch ID for sensitive actions  
- 🚫 **Jailbreak Detection** — Prevent execution on compromised devices  

---

## 🚀 Features & Flow

- 🖼 **Splash & Onboarding:** Animated SwiftUI multi-step flow  
- 🔐 **Login:** Basic placeholder validation (Firebase OTP planned)  
- 📋 **Coin List:**  
  - Pagination (20 coins/page)  
  - Sort/filter by price and 24h performance  
  - Swipe-to-favorite  
- 📈 **Coin Detail:** Price history charts with time filters  
- ⭐ **Favorites:** Easily manage saved coins  
- 🌙 **Dark Mode:** Automatic theme switching  

---

## ⚠ Known Limitations

- Firebase OTP not yet implemented  
- No offline caching beyond `UserDefaults`  
- Basic error handling for login & networking  

---

## 📦 Build & Run

1. Clone:
   ```bash
   git clone https://github.com/username/CoinRankingCrypto.git
   cd CoinRankingCrypto
   pod install
   open CoinRankingCrypto.xcworkspace

## 📊 Visual Architecture Diagram

```mermaid
flowchart TB
    subgraph Presentation[Presentation Layer]
        UI[UIKit / SwiftUI Views]
        VM[ViewModels]
        C[Coordinators]
    end
    
    subgraph Domain[Domain Layer]
        UC[Use Cases]
        E[Entities]
    end
    
    subgraph Data[Data Layer]
        R[Repositories]
        API[Networking (Alamofire + SSL Pinning)]
        DB[Persistence]
    end
    
    UI -- Solid: Navigation --> C
    C -- Solid: Navigation --> UI
    UI -- Solid: User Actions --> VM
    VM -. Dashed: Data Flow .-> UC
    UC -. Dashed: Data Flow .-> R
    R -. Dashed: Network Calls .-> API
    R -. Dashed: Local Storage .-> DB
    
    style Presentation fill:#fce4ec,stroke:#f06292,stroke-width:2px
    style Domain fill:#e3f2fd,stroke:#42a5f5,stroke-width:2px
    style Data fill:#e8f5e9,stroke:#66bb6a,stroke-width:2px
