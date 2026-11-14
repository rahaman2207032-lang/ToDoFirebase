import Foundation
import FirebaseFirestore
import Combine
// Firestore layout:  users/{userId}/notes/{noteId}
@MainActor
final class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []

    private var db: Firestore { Firestore.firestore() }

    private func notesRef(_ userId: String) -> CollectionReference {
        db.collection("users").document(userId).collection("notes")
    }

    func fetchNotes(userId: String) async {
        do {
            let snapshot = try await notesRef(userId)
                .order(by: "createdAt", descending: true)
                .getDocuments()
            notes = snapshot.documents.compactMap { try? $0.data(as: Note.self) }
        } catch {
            print("Fetch error:", error.localizedDescription)
        }
    }

    // Used for both "add new" and "update existing"
    func saveNote(_ note: Note, userId: String) {
        do {
            try notesRef(userId).document(note.id).setData(from: note)
            if let index = notes.firstIndex(where: { $0.id == note.id }) {
                notes[index] = note
            } else {
                notes.insert(note, at: 0)
            }
        } catch {
            print("Save error:", error.localizedDescription)
        }
    }

    func deleteNote(_ note: Note, userId: String) {
        notesRef(userId).document(note.id).delete()
        notes.removeAll { $0.id == note.id }
    }
}
