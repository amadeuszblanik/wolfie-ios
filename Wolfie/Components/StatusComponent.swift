//
//  StatusComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import SwiftUI

struct UIStatus: View {
    var message: String?
    var icon = "warning-outline"
    var color: Color = .orange
    var onTryAgain: (() -> Void)?

    init(_ message: String?, icon: String? = nil, color: Color? = .orange, onTryAgain: (() -> Void)? = nil) {
        if let message = message {
            self.message = message
        }
        if let icon = icon {
            self.icon = icon
        }
        if let color = color {
            self.color = color
        }
        if let onTryAgain = onTryAgain {
            self.onTryAgain = onTryAgain
        }
    }

    var body: some View {
        VStack {
            Image(icon)
                .resizable()
                .frame(width: 64.0, height: 64.0)
                .padding(.bottom)
                .foregroundColor(color)

            Text(message ?? String(localized: "error_generic_title"))
                .font(.headline)
                .multilineTextAlignment(.center)

            if let onTryAgain = self.onTryAgain {
                UIButton(text: String(localized: "retry"), color: color, fullWidth: true) {
                    onTryAgain()
                }
                .padding(.top)
            }
        }
    }
}

struct UIStatus_Previews: PreviewProvider {
    static var message = "Something went wrong. Please try again later."

    static func handleTryAgain() {
        print("Handle try again")
    }

    static var previews: some View {
        UIStatus(message)
        UIStatus(message)
            .preferredColorScheme(.dark)

        UIStatus(nil)
        UIStatus(nil)
            .preferredColorScheme(.dark)

        UIStatus(message, onTryAgain: handleTryAgain)
        UIStatus(message, onTryAgain: handleTryAgain)
            .preferredColorScheme(.dark)
    }
}
