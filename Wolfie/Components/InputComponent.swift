//
//  InputComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

enum InputTypes {
    case Text
    case Password
    case Number
}

struct UIInput: View {
    var label: String!
    var placeholder: String?
    var suffix: String?
    @Binding var state: String
    var keyboardType: UIKeyboardType = UIKeyboardType.default
    var type: InputTypes = InputTypes.Text
    var error: String?
    var hint: String?

    var body: some View {
        VStack(alignment: .trailing) {
            if (state.count > 0 || (placeholder != nil)) {
                Text(label ?? "")
                    .font(.headline)
                    .foregroundColor(Color.gray)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .transition(.slide)
            }

            HStack(alignment: .lastTextBaseline) {
                switch type {
                case .Text:
                    TextField(placeholder ?? label ?? "", text: $state)
                        .padding()
                        .foregroundColor(Color(.label))
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .keyboardType(keyboardType)
                case .Number:
                    TextField(placeholder ?? label ?? "", text: $state)
                        .padding()
                        .foregroundColor(Color(.label))
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .keyboardType(.decimalPad)
                case .Password:
                    SecureField(label, text: $state)
                        .padding()
                        .foregroundColor(Color(.label))
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                        .keyboardType(keyboardType)
                }

                if suffix != nil {
                    Text(suffix!)
                        .font(.title3)
                        .fontWeight(.light)
                }
            }

            HStack(alignment: .top) {
                if error != nil {
                    Text(error!)
                        .font(.caption)
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .transition(.slide)
                }

                if hint != nil {
                    Text(hint!)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .topTrailing)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .transition(.slide)
                }
            }
        }
    }
}

struct UIInput_Previews: PreviewProvider {
    @State static var state = ""

    static var previews: some View {
        VStack {
            UIInput(label: "Default input", state: $state)
                .padding()

            UIInput(label: "Default input", placeholder: "goldie@doggo.rocks", state: $state)
                .padding()

            UIInput(label: "Password input", state: $state, type: .Password)
                .padding()

            UIInput(label: "E-mail address", placeholder: "goldie@doggo.rocks", state: $state, keyboardType: .emailAddress, error: "Wrong e-mail format")
                .padding()

            UIInput(label: "Password", state: $state, type: .Password, error: "Password should have 1 upper case, lowcase letter along with a number and special character.")
                .padding()

            UIInput(label: "E-mail address", state: $state, keyboardType: .emailAddress, hint: "goldie@doggo.rocks")
                .padding()

            UIInput(label: "E-mail address", placeholder: "goldie@doggo.rocks", state: $state, keyboardType: .emailAddress, error: "Wrong e-mail format", hint: "Example: goldie@doggo.rocks")
                .padding()

            UIInput(label: "Password", state: $state, type: .Password, error: "Password should have 1 upper case, lowcase letter along with a number and special character.", hint: "Must be secure!")
                .padding()

            UIInput(label: "Weight", suffix: "kg", state: $state, type: .Number)
                .padding()
        }
            .preferredColorScheme(.light)

        VStack {
            UIInput(label: "Default input", state: $state)
                .padding()

            UIInput(label: "Default input", placeholder: "goldie@doggo.rocks", state: $state)
                .padding()

            UIInput(label: "Password input", state: $state, type: .Password)
                .padding()

            UIInput(label: "E-mail address", placeholder: "goldie@doggo.rocks", state: $state, keyboardType: .emailAddress, error: "Wrong e-mail format")
                .padding()

            UIInput(label: "Password", state: $state, type: .Password, error: "Password should have 1 upper case, lowcase letter along with a number and special character.")
                .padding()

            UIInput(label: "E-mail address", state: $state, keyboardType: .emailAddress, hint: "goldie@doggo.rocks")
                .padding()

            UIInput(label: "E-mail address", placeholder: "goldie@doggo.rocks", state: $state, keyboardType: .emailAddress, error: "Wrong e-mail format", hint: "Example: goldie@doggo.rocks")
                .padding()

            UIInput(label: "Password", state: $state, type: .Password, error: "Password should have 1 upper case, lowcase letter along with a number and special character.", hint: "Must be secure!")
                .padding()

            UIInput(label: "Weight", suffix: "kg", state: $state, type: .Number)
                .padding()
        }
            .preferredColorScheme(.dark)
    }
}
