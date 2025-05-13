//
//  TextFieldAction.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 12/11/24.
//
import Foundation
import SwiftUI

extension TextField {
    @ViewBuilder
    // we can also change "showSuggestion" to Dynamic by crating is with @biding

    func menu(showSuggestion:Bool = true,  @UITextFieldActionBuilder actions: () ->[TextFiledAction]) -> some View{
        self
            .background(TextFieldActionHelper(showSuggestions: showSuggestion , action: actions()))
            .compositingGroup()
    }
}
struct TextFiledAction{
    var title:String
    var action:(NSRange, UITextField)->()
}

@resultBuilder
struct UITextFieldActionBuilder {
    static func buildBlock(_ actions: TextFiledAction...) -> [TextFiledAction] {
        actions.compactMap({ $0 })
    }
}

fileprivate struct TextFieldActionHelper: UIViewRepresentable {
   
    var showSuggestions:Bool
    var action:[TextFiledAction]
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        DispatchQueue.main.async {
            if let textField = view.superview?.superview?.subviews.last?.subviews.first as? UITextField {
                textField.delegate =  context.coordinator
                print(textField)
            }
        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    class Coordinator:NSObject, UITextFieldDelegate{
        var parent:TextFieldActionHelper
        init(parent:TextFieldActionHelper){
            self.parent = parent
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print("textFieldDidBeginEditing")
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("textFieldDidEndEditing")
        }
        func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
            var actions:[UIMenuElement] = []
            let customAction = parent.action.compactMap {  item  in
                let action = UIAction(title: item.title ) { _ in
                  item.action(range, textField)
                }
                return action
            }
            if parent.showSuggestions {
                actions = customAction + suggestedActions
            }else{
                actions = customAction
            }
            let menu = UIMenu(title: "sample", children: actions)
            return menu
        }
    }
    
}

#Preview {
    ListView(vm: ListVM())
}


