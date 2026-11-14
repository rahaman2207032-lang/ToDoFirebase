import SwiftUI

// Opens a saved list. Ticking a checkbox saves to Firebase automatically.
struct NoteDetailView: View {
    @State var note: Note
    let userId: String
    @ObservedObject var noteVM: NoteViewModel

    var body: some View {
        List {
            Section {
                ForEach($note.items) { $item in
                    CheckboxRow(item: $item)
                }
            } header: {
                Text("\(note.doneCount) of \(note.items.count) completed")
            }
        }
        .navigationTitle(note.title)
        .onChange(of: note) { _, newValue in
            noteVM.saveNote(newValue, userId: userId)
        }
    }
}
