import Foundation

// One checkbox line inside a to-do list
struct TodoItem: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var text: String
    var isDone: Bool = false
}

// One saved to-do list. `title` is the heading shown on the main screen.
struct Note: Identifiable, Codable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var items: [TodoItem]
    var createdAt: Date = Date()

    var doneCount: Int { items.filter { $0.isDone }.count }
}
