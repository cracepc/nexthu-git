import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let userService = UserService()
    
    func loadUser() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await userService.getCurrentUser()
            self.user = user
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func updateProfile(name: String, email: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let updatedUser = try await userService.updateUser(name: name, email: email)
            self.user = updatedUser
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}