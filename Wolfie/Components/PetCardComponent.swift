//
//  PetCardComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct PetCardDetailText: View {
    var label: String!
    var value: String!

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label)
            Text(value)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct PetCardComponent: View {
    var pet: PetDB!

    var details: some View {
        Group {
            VStack(alignment: .leading) {
                PetCardDetailText(
                    label: String(localized: "age"),
                    value: pet.birthDate.toToday().toFormattedString()
                )

                PetCardDetailText(
                    label: String(localized: "birthday"),
                    value: pet.birthDate.toFormatted()
                )

                PetCardDetailText(
                    label: String(localized: "microchip"),
                    value: pet.microchip ?? "–"
                )

                PetCardDetailText(
                    label: String(localized: "breed"),
                    value: pet.breed?.localizedName ?? String(localized: "breed_mixed")
                )
            }
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(UIColor.lightText))
        }
    }

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(pet.name)
                    .font(.largeTitle)
                    .fontWeight(.medium)

                Spacer()

                UIAvatar(url: pet.image, size: 120.0)
            }
                .padding(.bottom)

            details
        }
            .padding(.vertical, 20)
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(
            LinearGradient(gradient: Gradient(colors: [.indigo, .blue]), startPoint: .bottomLeading, endPoint: .topTrailing)
        )
            .cornerRadius(8)
    }
}

struct PetCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PetCardComponent(pet: PetDB.fromApi(data: PET_GOLDIE))
        }
            .padding()

        VStack {
            PetCardComponent(pet: PetDB.fromApi(data: PET_GOLDIE))
        }
            .padding()
            .preferredColorScheme(.dark)

        VStack {
            PetCardComponent(pet: PetDB.fromApi(data: PET_TESTIE))
        }
            .padding()

        VStack {
            PetCardComponent(pet: PetDB.fromApi(data: PET_TESTIE))
        }
            .padding()
            .preferredColorScheme(.dark)
    }
}
