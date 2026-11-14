import SwiftUI

// Decides which screen to show: Login or the list of saved to-do lists
struct ContentView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        if let userId = authVM.userId {
            NoteListView(userId: userId)
        } else {
            LoginView()
        }
    }
}
