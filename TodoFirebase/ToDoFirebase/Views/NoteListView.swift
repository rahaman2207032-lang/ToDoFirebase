import SwiftUI

// Main screen: every saved to-do list appears as its own heading
struct NoteListView: View {
    let userId: String

    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var noteVM = NoteViewModel()
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                if noteVM.notes.isEmpty {
                    Text("No lists yet. Tap + to make one.")
                        .foregroundStyle(.secondary)
                }

                ForEach(noteVM.notes) { note in
                    NavigationLink(value: note) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(note.title)
                                .font(.headline)
                            Text("\(note.doneCount)/\(note.items.count) done")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete { offsets in
                    for index in offsets {
                        noteVM.deleteNote(noteVM.notes[index], userId: userId)
                    }
                }
            }
            .navigationTitle("My Plans")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Sign Out") { authVM.signOut() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        path.append("add")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // Where each NavigationLink / path value goes
            .navigationDestination(for: Note.self) { note in
                NoteDetailView(note: note, userId: userId, noteVM: noteVM)
            }
            .navigationDestination(for: String.self) { _ in
                AddNoteView(userId: userId, noteVM: noteVM, path: $path)
            }
            .task {
                await noteVM.fetchNotes(userId: userId)
            }
        }
    }
}
