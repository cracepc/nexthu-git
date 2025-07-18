import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            TodoView()
                .tabItem {
                    Image(systemName: "checklist")
                    Text("Todos")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct HomeView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Welcome to Nicosia App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                VStack(spacing: 20) {
                    TodoStatsView()
                    
                    FeatureCard(
                        icon: "checklist",
                        title: "Todo Manager",
                        description: "Keep track of your tasks and stay organized"
                    )
                    
                    FeatureCard(
                        icon: "person.circle",
                        title: "User Profile",
                        description: "Manage your account and preferences"
                    )
                    
                    FeatureCard(
                        icon: "gear",
                        title: "Settings",
                        description: "Customize your app experience"
                    )
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button("Get Started") {
                    viewModel.handleGetStarted()
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .navigationTitle("Home")
        }
    }
}

struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}