import SwiftUI

// A reusable checkbox line. @Binding lets it change the item owned by the parent view.
struct CheckboxRow: View {
    @Binding var item: TodoItem

    var body: some View {
        Button {
            item.isDone.toggle()
        } label: {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(item.isDone ? Color.green : Color.gray, lineWidth: 2)
                        .frame(width: 24, height: 24)

                    if item.isDone {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.green)
                            .frame(width: 24, height: 24)
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundStyle(.white)
                    }
                }

                Text(item.text)
                    .strikethrough(item.isDone)
                    .foregroundStyle(item.isDone ? .secondary : .primary)

                Spacer()
            }
            .contentShape(Rectangle())   // makes the whole row tappable
        }
        .buttonStyle(.plain)
    }
}
