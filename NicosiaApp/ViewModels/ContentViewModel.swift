import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var user: User?
    @Published var errorMessage: String?
    
    private let userService = UserService()
    
    func handleGetStarted() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let user = try await userService.getCurrentUser()
                self.user = user
                self.isLoading = false
            } catch {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func clearError() {
        errorMessage = nil
    }
}