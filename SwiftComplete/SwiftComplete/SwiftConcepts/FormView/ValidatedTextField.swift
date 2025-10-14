//
//  ValidatedTextField.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 23/09/2025.
//
import SwiftUI

enum FieldType: String {
    case name
    case phone
    case email
    case age
}

enum ValidationError: Error, LocalizedError {
    case empty
    case invalidName
    case invalidPhone
    case invalidEmail
    case invalidAge
    
    var errorDescription: String? {
        switch self {
        case .empty: return "Field cannot be empty"
        case .invalidName: return "Name must contain only letters and spaces"
        case .invalidPhone: return "Phone number must be 10 digits"
        case .invalidEmail: return "Invalid email format"
        case .invalidAge: return "Age must be between 0 and 120"
        }
    }
}

struct ValidatedTextField: View {
    let label: String
    let fieldType: FieldType
    @Binding var text: String
    @Binding var error: String?
    @FocusState private var isFocused: Bool
    @Binding var focusedField: FieldType?
    
    private func validate() -> ValidationError? {
        guard !text.isEmpty else {
            return .empty
        }
        
        switch fieldType {
        case .name:
            let nameRegex = "^[A-Za-z\\s]+$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
            return predicate.evaluate(with: text) ? nil : .invalidName
            
        case .phone:
            let phoneRegex = "^[0-9]{10}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return predicate.evaluate(with: text) ? nil : .invalidPhone
            
        case .email:
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return predicate.evaluate(with: text) ? nil : .invalidEmail
            
        case .age:
            if let ageNum = Int(text), ageNum >= 0, ageNum <= 120 {
                return nil
            }
            return .invalidAge
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(label, text: $text)
                .textFieldStyle(.roundedBorder)
                .keyboardType(fieldType == .phone || fieldType == .age ? .numberPad : .default)
                .focused($isFocused)
                .onChange(of: text) { _ in
                    error = validate()?.errorDescription
                }
                .onChange(of: isFocused) { newValue in
                    focusedField = newValue ? fieldType : nil
                }
                .onChange(of: focusedField) { newValue in
                    isFocused = (newValue == fieldType)
                }
                .onSubmit {
                    error = validate()?.errorDescription
                }
            
            if let errorText = error {
                Text(errorText)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
        .padding(.vertical, 4)
    }
}

struct ValidatedTextField_Previews: PreviewProvider {
    static var previews: some View {
        ValidatedTextField(
            label: "Name",
            fieldType: .name,
            text: .constant(""),
            error: .constant(nil),
            focusedField: .constant(nil)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
