import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: "https://via.placeholder.com/150")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 150)
            }
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            
            if let user = viewModel.user {
                VStack(spacing: 8) {
                    Text(user.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(user.email)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Profile")
        .task {
            await viewModel.loadUser()
        }
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}