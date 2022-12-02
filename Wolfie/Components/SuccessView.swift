//
//  SuccessView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 30/11/2022.
//

import SwiftUI

struct UISuccess: View {
    var message = String(localized: "success_generic_message")
    var iconSize = 120.0

    var body: some View {
        VStack {
            Image("checkmark-circle-outline")
                .resizable()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(.green)
                .padding(.bottom)
            Text(message)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding(.bottom)
        }
    }
}

struct UISuccess_Previews: PreviewProvider {
    static var customMessage = "Form sent!\nWe will respond as soon as possible."

    static var previews: some View {
        VStack {
            UISuccess()
        }
        .padding(.horizontal)
        VStack {
            UISuccess()
        }
        .padding(.horizontal)
        .preferredColorScheme(.dark)

        VStack {
            UISuccess(message: customMessage)
        }
        .padding(.horizontal)
        VStack {
            UISuccess(message: customMessage)
        }
        .padding(.horizontal)
        .preferredColorScheme(.dark)
    }
}
