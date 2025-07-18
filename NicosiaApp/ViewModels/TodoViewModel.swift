import Foundation
import Combine

@MainActor
class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let todoService = TodoService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadTodos()
    }
    
    func loadTodos() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let todos = try await todoService.getAllTodos()
                self.todos = todos.sorted { !$0.isCompleted && $1.isCompleted }
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func addTodo(title: String, priority: Todo.Priority = .medium) {
        let newTodo = Todo(title: title, priority: priority)
        
        Task {
            do {
                let savedTodo = try await todoService.saveTodo(newTodo)
                self.todos.append(savedTodo)
                sortTodos()
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func toggleTodo(_ todo: Todo) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        
        var updatedTodo = todo
        updatedTodo.toggle()
        
        Task {
            do {
                let savedTodo = try await todoService.updateTodo(updatedTodo)
                self.todos[index] = savedTodo
                sortTodos()
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func deleteTodos(at offsets: IndexSet) {
        let todosToDelete = offsets.map { todos[$0] }
        
        Task {
            do {
                for todo in todosToDelete {
                    try await todoService.deleteTodo(todo)
                }
                self.todos.remove(atOffsets: offsets)
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func updateTodo(_ todo: Todo) {
        guard let index = todos.firstIndex(where: { $0.id == todo.id }) else { return }
        
        Task {
            do {
                let updatedTodo = try await todoService.updateTodo(todo)
                self.todos[index] = updatedTodo
                sortTodos()
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    private func sortTodos() {
        todos.sort { first, second in
            if first.isCompleted != second.isCompleted {
                return !first.isCompleted
            }
            return first.createdAt > second.createdAt
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
    
    // MARK: - Computed Properties
    
    var completedTodos: [Todo] {
        todos.filter { $0.isCompleted }
    }
    
    var pendingTodos: [Todo] {
        todos.filter { !$0.isCompleted }
    }
    
    var completionPercentage: Double {
        guard !todos.isEmpty else { return 0 }
        return Double(completedTodos.count) / Double(todos.count) * 100
    }
}