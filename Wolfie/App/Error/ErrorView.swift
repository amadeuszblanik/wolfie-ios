//
//  ErrorView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 30/11/2022.
//

import SwiftUI

struct ErrorView: View {
    var iconSize = 120.0
    var title = String(localized: "error_generic_title")
    var message = String(localized: "error_generic_message")
    var accent: Color = .orange
    var feedback = false
    var onTryAgain: (() -> Void)?

    @State private var isFeedbackOpen = false

    var body: some View {
        VStack {
            Spacer()
            Image("warning-outline")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(accent)
            Spacer()
            Text(title)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(message)
                .font(.body)
                .multilineTextAlignment(.center)
            Spacer()
            Spacer()

            if feedback {
                UIButton(text: String(localized: "feedback"), color: accent, fullWidth: true) {
                    isFeedbackOpen = true
                }
                .sheet(isPresented: $isFeedbackOpen) {
                    FeedbackForm(message: message)
                }
            }

            if let handleTryagain = onTryAgain {
                UIButton(text: String(localized: "retry"), fullWidth: true) {
                    handleTryagain()
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static func handleTryAgain() {
        print("Try again")
    }

    static var previews: some View {
        ErrorView()
        ErrorView()
            .preferredColorScheme(.dark)

        ErrorView(feedback: true)
        ErrorView(feedback: true)
            .preferredColorScheme(.dark)

        ErrorView(feedback: true, onTryAgain: handleTryAgain)
        ErrorView(feedback: true, onTryAgain: handleTryAgain)
            .preferredColorScheme(.dark)
    }
}
