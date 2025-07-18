import SwiftUI

struct TodoView: View {
    @StateObject private var viewModel = TodoViewModel()
    @State private var showingAddTodo = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.todos.isEmpty {
                    emptyStateView
                } else {
                    todoListView
                }
                
                Spacer()
                
                addButton
            }
            .navigationTitle("Todos")
            .navigationBarItems(trailing: EditButton())
            .sheet(isPresented: $showingAddTodo) {
                AddTodoView(viewModel: viewModel)
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "checklist")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No todos yet")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("Add your first todo to get started!")
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
    }
    
    private var todoListView: some View {
        List {
            ForEach(viewModel.todos) { todo in
                TodoRowView(todo: todo) {
                    viewModel.toggleTodo(todo)
                }
            }
            .onDelete(perform: viewModel.deleteTodos)
        }
        .listStyle(PlainListStyle())
    }
    
    private var addButton: some View {
        Button(action: {
            showingAddTodo = true
        }) {
            HStack {
                Image(systemName: "plus")
                Text("Add Todo")
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
    }
}

struct TodoRowView: View {
    let todo: Todo
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(todo.isCompleted ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .font(.body)
                    .strikethrough(todo.isCompleted)
                    .foregroundColor(todo.isCompleted ? .secondary : .primary)
                
                HStack {
                    Text(todo.priority.rawValue)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color(todo.priority.color).opacity(0.2))
                        .cornerRadius(4)
                    
                    Spacer()
                    
                    Text(DateHelper.formatDate(todo.createdAt))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct AddTodoView: View {
    @ObservedObject var viewModel: TodoViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var selectedPriority = Todo.Priority.medium
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Todo Details")) {
                    TextField("Todo title", text: $title)
                    
                    Picker("Priority", selection: $selectedPriority) {
                        ForEach(Todo.Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue).tag(priority)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Add Todo")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Add") {
                    viewModel.addTodo(title: title, priority: selectedPriority)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(title.isEmpty)
            )
        }
    }
}

#Preview {
    TodoView()
}