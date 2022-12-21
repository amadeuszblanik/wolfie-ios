//
//  StatusComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import SwiftUI

struct UIStatus: View {
    var message: String
    var icon = "warning-outline"
    var onTryAgain: (() -> Void)?

    init(_ message: String, icon: String? = nil, onTryAgain: (() -> Void)? = nil) {
        self.message = message
        if let icon = icon {
            self.icon = icon
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
                .foregroundColor(.orange)

            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)

            if let onTryAgain = self.onTryAgain {
                UIButton(text: String(localized: "retry"), color: .orange, fullWidth: true) {
                    onTryAgain()
                }
                .padding(.top)
            }
        }
    }
}

struct UIStatus_Previews: PreviewProvider {
    static func handleTryAgain() {
        print("Handle try again")
    }

    static var previews: some View {
        UIStatus("Something went wrong")
        UIStatus("Something went wrong")
            .preferredColorScheme(.dark)

        UIStatus("Something went wrong", onTryAgain: handleTryAgain)
        UIStatus("Something went wrong", onTryAgain: handleTryAgain)
            .preferredColorScheme(.dark)
    }
}
