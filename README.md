# TodoFirebase

A simple SwiftUI to-do list app. Each list you save appears as its own heading, and every task has a checkbox. Data is stored per user in Firebase.

## Features
- Email / password sign up and log in (Firebase Authentication)
- Create a to-do list with a heading and checkbox tasks
- Saved lists shown as headings on the home screen
- Tick tasks on/off — changes save to Cloud Firestore automatically
- Swipe to delete a list or a task

## Tech Stack
- SwiftUI (iOS 17+)
- MVVM (`AuthViewModel`, `NoteViewModel`)
- Firebase Auth + Cloud Firestore (Swift Package Manager)

## Project Structure
```
TodoFirebase/
├── TodoFirebaseApp.swift      # App entry, FirebaseApp.configure()
├── Models/
│   └── Note.swift             # Note (heading) + TodoItem (checkbox)
├── ViewModels/
│   ├── AuthViewModel.swift    # sign up / sign in / sign out
│   └── NoteViewModel.swift    # fetch / save / delete lists
└── Views/
    ├── ContentView.swift      # Login or Home
    ├── LoginView.swift
    ├── NoteListView.swift     # Home: list of headings
    ├── AddNoteView.swift      # Create a new list
    ├── NoteDetailView.swift   # Open a list, tick tasks
    └── CheckboxRow.swift      # Reusable checkbox
```

## Firestore Data Layout
```
users/{userId}/notes/{noteId}
    title: String
    items: [{ id, text, isDone }]
    createdAt: Timestamp
```

## Screenshots
| Login | Home | New List | Detail |
|-------|------|----------|--------|
| ![](docs/screenshots/login.png) | ![](docs/screenshots/home.png) | ![](docs/screenshots/add.png) | ![](docs/screenshots/detail.png) |

## Setup
1. Clone the repo and open it on a Mac with Xcode 15 or newer.
2. Create a Firebase project, add an iOS app with bundle ID `com.yourname.TodoFirebase`.
3. Download `GoogleService-Info.plist` and drag it into the `TodoFirebase` folder in Xcode (not committed to this repo).
4. Enable **Authentication → Email/Password** and create a **Firestore** database.
5. Build and run.
