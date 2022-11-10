//
//  CardComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI

struct CardComponent: View {
    var label: String!
    var icon: String!
    var value: String?
    var background: Color = .accentColor
    var iconSize = 64.0
    
    var body: some View {
        VStack {
            HStack {
                Image(icon)
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(alignment: .lastTextBaseline) {
                Text(label)
                    .lineLimit(1)
                Text(value ?? "—")
                    .font(.title)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(background)
        .cornerRadius(8)
    }
}

struct CardComponent_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CardComponent(
                label: "Weight",
                icon: "barbell-outline",
                value: "14.2 KG"
            )
            CardComponent(
                label: "Health log",
                icon: "heart-outline",
                background: .red
            )
        }
        .padding(.horizontal)

        HStack {
            CardComponent(
                label: "Weight",
                icon: "barbell-outline",
                value: "14.2 KG"
            )
            CardComponent(
                label: "Health log",
                icon: "heart-outline",
                background: .red
            )
        }
        .padding(.horizontal)
        .preferredColorScheme(.dark)
    }
}
