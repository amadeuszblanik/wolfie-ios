//
//  ButtonComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct UIButton: View {
    var text = "Button text"
    var color: Color = Color.accentColor
    var fullWidth: Bool = false
    var outline: Bool = false
    var action: (() -> Void)

    @Environment(\.isEnabled) var isEnabled

    private var backgroundColor: Color {
        isEnabled ? (outline ? .clear : color) : Color(UIColor.darkGray)
    }

    private var strokeColor: Color {
        isEnabled ? color : Color(UIColor.darkGray)
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(maxWidth: self.fullWidth ? .infinity : nil)
                .padding(.vertical, 16.0)
                .padding(.horizontal, 32.0)
                .background(backgroundColor)
                .foregroundColor(Color(.label))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(strokeColor, lineWidth: 1)
                )
        }
    }
}

struct UIButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                UIButton(text: "Lorem ipsum") {
                    print("Clicked")
                }

                UIButton(text: "Disabled state") {
                    print("Clicked")
                }
                .disabled(true)

                UIButton(text: "Lorem ipsum", color: .purple) {
                    print("Clicked")
                }

                UIButton(text: "Disabled state", color: .purple) {
                    print("Clicked")
                }
                .disabled(true)

                UIButton(text: "Lorem ipsum", fullWidth: true) {
                    print("Clicked")
                }

                UIButton(text: "Disabled state", fullWidth: true) {
                    print("Clicked")
                }
                .disabled(true)

                UIButton(text: "Lorem ipsum", outline: true) {
                    print("Clicked")
                }

                UIButton(text: "Disabled state", outline: true) {
                    print("Clicked")
                }
                .disabled(true)
            }
            .padding(.horizontal)

            VStack {
                UIButton(text: "Lorem ipsum") {
                    print("Clicked")
                }

                UIButton(text: "Disabled state") {
                    print("Clicked")
                }
                .disabled(true)

                UIButton(text: "Lorem ipsum", color: .purple) {
                    print("Clicked")
                }

                UIButton(text: "Disabled state", color: .purple) {
                    print("Clicked")
                }
                .disabled(true)

                UIButton(text: "Lorem ipsum", fullWidth: true) {
                    print("Clicked")
                }

                UIButton(text: "Disabled state", fullWidth: true) {
                    print("Clicked")
                }
                .disabled(true)

                UIButton(text: "Lorem ipsum", outline: true) {
                    print("Clicked")
                }

                UIButton(text: "Disabled state", outline: true) {
                    print("Clicked")
                }
                .disabled(true)
            }
            .padding(.horizontal)
            .preferredColorScheme(.dark)
        }
    }
}
