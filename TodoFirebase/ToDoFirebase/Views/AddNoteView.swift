import SwiftUI

// Screen for writing a new to-do list and saving it under a heading
struct AddNoteView: View {
    let userId: String
    @ObservedObject var noteVM: NoteViewModel
    @Binding var path: NavigationPath

    @State private var title = ""
    @State private var newItemText = ""
    @State private var items: [TodoItem] = []

    var body: some View {
        VStack(spacing: 12) {
            TextField("Heading (e.g. Saturday Plan)", text: $title)
                .font(.title2.bold())
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))

            HStack {
                TextField("Add a task", text: $newItemText)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.4)))

                Button {
                    addItem()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                }
                .disabled(newItemText.trimmingCharacters(in: .whitespaces).isEmpty)
            }

            List {
                ForEach($items) { $item in
                    CheckboxRow(item: $item)
                }
                .onDelete { items.remove(atOffsets: $0) }
            }
            .listStyle(.plain)

            Spacer()

            Button {
                let note = Note(title: title, items: items)
                noteVM.saveNote(note, userId: userId)
                path.removeLast()          // go back to the main list
            } label: {
                Text("Save List")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Capsule().fill(title.isEmpty ? .gray : .blue))
            }
            .disabled(title.isEmpty)
        }
        .padding()
        .navigationTitle("New List")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addItem() {
        let text = newItemText.trimmingCharacters(in: .whitespaces)
        items.append(TodoItem(text: text))
        newItemText = ""
    }
}
