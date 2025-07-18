import Foundation

protocol TodoServiceProtocol {
    func getAllTodos() async throws -> [Todo]
    func saveTodo(_ todo: Todo) async throws -> Todo
    func updateTodo(_ todo: Todo) async throws -> Todo
    func deleteTodo(_ todo: Todo) async throws
}

class TodoService: TodoServiceProtocol {
    private let storageKey = "todos_storage"
    
    func getAllTodos() async throws -> [Todo] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 300_000_000)
        
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let todos = try? JSONDecoder().decode([Todo].self, from: data) else {
            // Return mock data if no stored todos
            return Todo.mockTodos
        }
        
        return todos
    }
    
    func saveTodo(_ todo: Todo) async throws -> Todo {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 200_000_000)
        
        var todos = try await getAllTodos()
        todos.append(todo)
        
        try await saveTodos(todos)
        
        return todo
    }
    
    func updateTodo(_ todo: Todo) async throws -> Todo {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 200_000_000)
        
        var todos = try await getAllTodos()
        
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else {
            throw TodoError.todoNotFound
        }
        
        todos[index] = todo
        
        try await saveTodos(todos)
        
        return todo
    }
    
    func deleteTodo(_ todo: Todo) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 200_000_000)
        
        var todos = try await getAllTodos()
        
        todos.removeAll { $0.id == todo.id }
        
        try await saveTodos(todos)
    }
    
    private func saveTodos(_ todos: [Todo]) async throws {
        let data = try JSONEncoder().encode(todos)
        UserDefaults.standard.set(data, forKey: storageKey)
    }
}

enum TodoError: Error, LocalizedError {
    case todoNotFound
    case saveFailed
    case loadFailed
    
    var errorDescription: String? {
        switch self {
        case .todoNotFound:
            return "Todo not found"
        case .saveFailed:
            return "Failed to save todo"
        case .loadFailed:
            return "Failed to load todos"
        }
    }
}