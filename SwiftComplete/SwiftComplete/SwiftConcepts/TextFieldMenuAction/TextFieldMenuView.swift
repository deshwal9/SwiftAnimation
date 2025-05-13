//
//  TextFieldMenuView.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//

import SwiftUI

struct TextFieldMenuView: View {
    @ObservedObject var vm: TextFieldMenuVM
    @State private var message:String = ""
    var body: some View {
        List{
            //MARK: Sample 3: TextField Menu Action
            Section("Textfield"){
                TextField("Message", text: $message)
                    .menu(showSuggestion: true) {
                        TextFiledAction(title: "upperCase") { _, textfield in
                            print("Tapped")
                        }
                        TextFiledAction(title: "lowecase") { _, textfield in
                            print("Tapped")
                        }
                    }
            }
        }
    }
}

#Preview {
    TextFieldMenuView(vm: TextFieldMenuVM())
}
