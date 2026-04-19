//
//  TaskGroupView.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 20/01/2026.
//

import SwiftUI

struct TaskGroupView: View {
    @State private var logs: [String] = []
    @State private var isRunning = false
    @State private var parentTask: Task<Void, Never>? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Swift Concurrency TaskGroup Demo")
                .font(.title2)
                .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(logs, id: \.self) { log in
                        Text(log)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(log.contains("cancelled") ? .red : .blue)
                    }
                }
            }
            .frame(height: 300)
            .padding()
            .border(Color.gray)

            HStack(spacing: 20) {
                Button(action: startTasks) {
                    Text(isRunning ? "Running..." : "Start Tasks")
                        .padding()
                        .background(isRunning ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(isRunning)

                Button(action: cancelTasks) {
                    Text("Cancel Tasks")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!isRunning)
            }
        }
        .padding()
    }

    func startTasks() {
        logs.removeAll()
        isRunning = true

        parentTask = Task {
            logs.append("Parent task started")
            
            await withTaskGroup(of: String.self) { group in
                for i in 1...5 {
                    group.addTask {
                        logs.append("Subtask \(i) started")
                        do {
                            try await Task.sleep(for: .seconds(i))
                            return "Subtask \(i) finished"
                        } catch {
                            return "Subtask \(i) cancelled"
                        }
                    }
                }

                for await result in group {
                    logs.append(result)
                }
            }

            logs.append("Parent task completed")
            isRunning = false
        }
    }

    func cancelTasks() {
        logs.append("Cancelling parent task...")
        parentTask?.cancel()
    }
}

#Preview {
  TaskGroupView()
}
