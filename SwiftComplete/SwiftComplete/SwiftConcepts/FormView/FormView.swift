//
//  FormView.swift
//  SwiftComplete
//
//  Created by Ankit Deshwal on 23/09/2025.
//

import SwiftUI

struct FormView: View {
    @State private var name = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var age = ""
    
    @State private var nameError: String?
    @State private var phoneError: String?
    @State private var emailError: String?
    @State private var ageError: String?
    
    @State private var focusedField: FieldType?
    
    private var isFormValid: Bool {
        nameError == nil && phoneError == nil && emailError == nil && ageError == nil &&
        !name.isEmpty && !phone.isEmpty && !email.isEmpty && !age.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    ValidatedTextField(
                        label: "Full Name",
                        fieldType: .name,
                        text: $name,
                        error: $nameError,
                        focusedField: $focusedField
                    )
                    
                    ValidatedTextField(
                        label: "Phone Number",
                        fieldType: .phone,
                        text: $phone,
                        error: $phoneError,
                        focusedField: $focusedField
                    )
                    
                    ValidatedTextField(
                        label: "Email",
                        fieldType: .email,
                        text: $email,
                        error: $emailError,
                        focusedField: $focusedField
                    )
                    
                    ValidatedTextField(
                        label: "Age",
                        fieldType: .age,
                        text: $age,
                        error: $ageError,
                        focusedField: $focusedField
                    )
                }
                
                Button(action: {
                    // Submit action
                    print("Form submitted: Name: \(name), Phone: \(phone), Email: \(email), Age: \(age)")
                }) {
                    Text("Submit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(!isFormValid)
            }
            .navigationTitle("User Registration")
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
