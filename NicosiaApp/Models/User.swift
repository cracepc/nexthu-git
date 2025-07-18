import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let name: String
    let email: String
    let createdAt: Date
    
    init(name: String, email: String) {
        self.id = UUID()
        self.name = name
        self.email = email
        self.createdAt = Date()
    }
}

extension User {
    static let mockUser = User(name: "John Doe", email: "john@example.com")
}