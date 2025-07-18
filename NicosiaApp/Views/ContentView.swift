import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to Nicosia App")
                    .font(.largeTitle)
                    .padding()
                
                Button("Get Started") {
                    viewModel.handleGetStarted()
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .navigationTitle("Nicosia")
        }
    }
}

#Preview {
    ContentView()
}