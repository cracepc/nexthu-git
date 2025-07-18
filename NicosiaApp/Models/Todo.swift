import Foundation

struct Todo: Codable, Identifiable, Equatable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var createdAt: Date
    var completedAt: Date?
    var priority: Priority
    
    enum Priority: String, CaseIterable, Codable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        
        var color: String {
            switch self {
            case .low: return "green"
            case .medium: return "orange"
            case .high: return "red"
            }
        }
    }
    
    init(title: String, priority: Priority = .medium) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.createdAt = Date()
        self.completedAt = nil
        self.priority = priority
    }
    
    mutating func toggle() {
        isCompleted.toggle()
        completedAt = isCompleted ? Date() : nil
    }
}

extension Todo {
    static let mockTodos = [
        Todo(title: "Complete iOS app development", priority: .high),
        Todo(title: "Review code changes", priority: .medium),
        Todo(title: "Update documentation", priority: .low),
        Todo(title: "Test app functionality", priority: .high)
    ]
}