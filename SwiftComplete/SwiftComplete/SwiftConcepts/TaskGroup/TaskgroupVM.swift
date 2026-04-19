//
//  TaskgroupVM.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 20/01/2026.
//

import Foundation
import SwiftUI
import UIKit

class TaskgroupVM: ObservableObject{
  
    func taskgroup(){
      
      Task {
          // Parent task
          let parentTask = Task {
              print("Parent task started")
              
              await withTaskGroup(of: String.self) { group in
                  // Add multiple subtasks
                  for i in 1...5 {
                      group.addTask {
                          // Check for cancellation
                          if Task.isCancelled {
                              return "Subtask \(i) cancelled immediately"
                          }
                          
                          // Simulate async work
                          do {
                              print("Subtask \(i) started")
                              try await Task.sleep(for: .seconds(i)) // simulate varying workload
                              return "Subtask \(i) finished"
                          } catch {
                              return "Subtask \(i) cancelled during sleep"
                          }
                      }
                  }
                  
                  // Collect results as they complete
                  for await result in group {
                      print(result)
                  }
              }
              
              print("Parent task completed")
          }
          
          // Optionally, cancel the parent task after some time
          try await Task.sleep(for: .seconds(3))
          print("Cancelling parent task...")
          parentTask.cancel()
      }

     
  }
    
}
//extension TaskgroupVM:ViewProvider {
//    
//    var view: AnyView {
//        return AnyView(TaskGroupView(vm: self))
//    }
//    
//    
//    
//}



