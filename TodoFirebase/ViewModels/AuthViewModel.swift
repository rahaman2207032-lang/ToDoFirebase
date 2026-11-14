import Foundation
import FirebaseAuth

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var userId: String?
    @Published var errorMessage = ""

    init() {
        // If the user logged in before, stay logged in
        userId = Auth.auth().currentUser?.uid
    }

    func signUp(email: String, password: String) async {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userId = result.user.uid
            errorMessage = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func signIn(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userId = result.user.uid
            errorMessage = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            userId = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
