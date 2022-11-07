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
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(maxWidth: self.fullWidth ? .infinity : nil)
                .padding(.vertical, 16.0)
                .padding(.horizontal, 32.0)
                .background(outline ? .clear : color)
                .foregroundColor(Color(.label))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(color, lineWidth: 1)
                )
        }
    }
}

struct UIButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UIButton(text: "Lorem ipsum") {
                print("Clicked")
            }
            .preferredColorScheme(.dark)

            UIButton(text: "Lorem ipsum", fullWidth: true) {
                print("Clicked")
            }
            .preferredColorScheme(.dark)
            
            UIButton(text: "Lorem ipsum", outline: true) {
                print("Clicked")
            }
            .preferredColorScheme(.dark)
        }
    }
}
