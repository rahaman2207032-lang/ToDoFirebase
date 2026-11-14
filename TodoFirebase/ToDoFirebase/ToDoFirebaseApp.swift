import SwiftUI
import FirebaseCore
import Combine

@main
struct TodoFirebaseApp: App {
    @StateObject private var authVM = AuthViewModel()

    init() {
        // Reads GoogleService-Info.plist and connects the app to Firebase
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
        }
    }
}
