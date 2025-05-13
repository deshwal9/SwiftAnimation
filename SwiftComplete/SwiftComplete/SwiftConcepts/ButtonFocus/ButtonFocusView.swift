
//
//  ButtonFocusView.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 30/03/2025.
//

import SwiftUI

struct ButtonFocusView: View {
  @ObservedObject var vm: ButtonFocusModel
  @FocusState private var isButtonFocused: Bool
  var body: some View {
    VStack {
      Text("Focus on the button below:")
      
      Button("Tap me") {
        // Handle button action
        print("Button tapped!")
      }
      .focused($isButtonFocused) // Apply focus state to the button
      .focusable(true, interactions: .automatic)
      
      Button("Another button") {
        // Handle another button action
      }
    }
    .onAppear {
      // Optionally set focus when the view appears
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        isButtonFocused = true
      }
    }
  }
}

#Preview {
  ButtonFocusView(vm: ButtonFocusModel())
}

