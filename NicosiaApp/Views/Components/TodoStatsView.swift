import SwiftUI

struct TodoStatsView: View {
    @StateObject private var viewModel = TodoViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Todo Progress")
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack(spacing: 20) {
                StatCard(
                    title: "Total",
                    value: "\(viewModel.todos.count)",
                    color: .blue
                )
                
                StatCard(
                    title: "Completed",
                    value: "\(viewModel.completedTodos.count)",
                    color: .green
                )
                
                StatCard(
                    title: "Pending",
                    value: "\(viewModel.pendingTodos.count)",
                    color: .orange
                )
            }
            
            if !viewModel.todos.isEmpty {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Completion Rate")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(Int(viewModel.completionPercentage))%")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    
                    ProgressView(value: viewModel.completionPercentage, total: 100)
                        .progressViewStyle(LinearProgressViewStyle(tint: .green))
                        .scaleEffect(y: 2)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}

#Preview {
    TodoStatsView()
        .padding()
}