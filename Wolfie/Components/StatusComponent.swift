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

    init(_ message: String, icon: String? = nil) {
        self.message = message
        if let icon = icon {
            self.icon = icon
        }
    }

    var body: some View {
        VStack {
            Image(icon)
                .resizable()
                .frame(width: 64.0, height: 64.0)
                .padding(.bottom)

            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
    }
}

struct UIStatus_Previews: PreviewProvider {
    static var previews: some View {
        UIStatus("Something went wrong")
        UIStatus("Something went wrong")
            .preferredColorScheme(.dark)
    }
}
