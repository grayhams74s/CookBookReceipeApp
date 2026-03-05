# 🍳 CookBook – Recipe App

**CookBook** is a modern SwiftUI recipe application that allows users to browse, view, and create cooking recipes.  
The app uses **Firebase Authentication**, **Firestore**, and **Firebase Storage** to manage user accounts and recipe data.

![FinalCookBookApp-ezgif com-video-to-gif-converter-3](https://github.com/user-attachments/assets/1fab6e96-62ea-4184-8ff7-42300566a674)

It demonstrates how to build a real-world iOS application using **SwiftUI**, **MVVM architecture**, and **Firebase backend services**.

![FinalCookBookApp-ezgif com-video-to-gif-converter-2](https://github.com/user-attachments/assets/44854624-ce02-4d0e-9fae-711dc82fe65a)


![FinalCookBookApp-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/5ad5cd74-54a6-42e3-a115-003b3c962c82)


---

# ✨ Features

### 🔐 Authentication
- User sign up and login
- Firebase Authentication integration
- Secure session management

### 📖 Browse Recipes
- Scroll through a list of recipes
- Each recipe displays:
  - Image
  - Name
  - Cooking time

### 🖼️ Remote Image Loading
- Recipe images are stored in **Firebase Storage**
- Loaded asynchronously using `AsyncImage`

### 🔍 Recipe Details
- Tap any recipe to view detailed information

### ➕ Create Recipes
- Floating **Make Recipe** button
- Add your own recipe with image and cooking time

### 🔄 Pull to Refresh
- Refresh recipe list using `refreshable`

### ⚙️ Account Settings
- Sign out using the settings button

### ⏳ Loading States
- Displays loading indicators while fetching recipes

---

# 🛠️ Tech Stack

### Frontend
- **SwiftUI**
- **NavigationStack**
- **AsyncImage**
- **MVVM Architecture**
- **Swift Concurrency (async/await)**

### Backend
- **Firebase Authentication** – User login and account management
- **Firebase Firestore** – Recipe data storage
- **Firebase Storage** – Image uploads and hosting

---

# 🧱 Architecture

The project follows **MVVM (Model–View–ViewModel)**.

## Views
- `HomeView`
- `ReceipeDetailView`
- `AddReceipeView`
- `SuccessComponentView`

## ViewModels
- `HomeViewModel`

Responsibilities:
- Fetch recipes from Firestore
- Manage loading state
- Handle sign-out logic

## Models
- `Receipe`

Represents:
- Recipe name
- Image URL
- Cooking time

---

# 📱 App Screens

### 🏠 Home Screen
- Displays recipe feed
- Tap to open recipe details
- Pull to refresh recipes

### 📄 Recipe Detail Screen
- Shows full recipe information

### ➕ Add Recipe Screen
- Upload recipe
- Add image and cooking time
- Image stored in Firebase Storage

### ⚙️ Settings
- Sign out of account

---

# 🔥 Firebase Services Used

### Firebase Authentication
Handles:
- User registration
- Login
- Session management

### Firestore Database
Stores:
- Recipe metadata
- User-created recipes


### Firebase Storage
Stores:
- Uploaded recipe images

---

# 🚀 Getting Started

## Requirements

- Xcode 15+
- iOS 17+
- Firebase Project

## Installation

1. Clone the repository

2. Open the project in **Xcode**

3. Add your **GoogleService-Info.plist**

4. Install Firebase dependencies (SPM)

5. Run the project

---

# 🧩 SwiftUI Concepts Demonstrated

- `NavigationStack`
- `LazyVStack`
- `AsyncImage`
- `sheet` presentation
- `refreshable`
- `task` modifier
- environment session management

---

# 📌 Project Purpose

This project demonstrates how to:

- Build a **production-style SwiftUI app**
- Integrate **Firebase backend**
- Use **MVVM architecture**
- Handle **image uploads and remote data**
- Implement **user authentication**

---

# 📄 License

This project is for educational and learning purposes.  
Feel free to modify, expand, and experiment.

---

Made with ❤️ using SwiftUI & Firebase
