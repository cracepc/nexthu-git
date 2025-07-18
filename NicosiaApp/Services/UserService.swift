import Foundation

protocol UserServiceProtocol {
    func getCurrentUser() async throws -> User
    func updateUser(name: String, email: String) async throws -> User
}

class UserService: UserServiceProtocol {
    private let networkService = NetworkService()
    
    func getCurrentUser() async throws -> User {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Return mock user for MVP
        return User.mockUser
    }
    
    func updateUser(name: String, email: String) async throws -> User {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Return updated mock user for MVP
        return User(name: name, email: email)
    }
}