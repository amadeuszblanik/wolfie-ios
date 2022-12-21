//
//  PetCardSkeletonComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import SwiftUI

struct PetCardSkeletonDetailText: View {
    var label: String!

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
            UISkeleton()
                .frame(maxWidth: 120)
                .frame(height: 17)
        }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct PetCardSkeletonComponent: View {
    var details: some View {
        Group {
            VStack(alignment: .leading) {
                PetCardSkeletonDetailText(
                    label: String(localized: "age")
                )

                PetCardSkeletonDetailText(
                    label: String(localized: "birthday")
                )

                PetCardSkeletonDetailText(
                    label: String(localized: "microchip")
                )

                PetCardSkeletonDetailText(
                    label: String(localized: "breed")
                )
            }
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(UIColor.lightText))
        }
    }

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                UISkeleton()
                    .frame(maxWidth: 120)
                    .frame(height: 34)

                Spacer()

                UISkeleton()
                    .frame(width: 120, height: 120)
            }
                .padding(.bottom)

            details
        }
            .padding(.vertical, 20)
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(
            LinearGradient(
                gradient: Gradient(colors: [.indigo, .blue]),
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
        )
            .cornerRadius(8)
    }
}

struct PetCardSkeletonComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PetCardSkeletonComponent()
        }
        .padding()
    }
}
