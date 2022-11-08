//
//  MyPets.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

let MOCKED_PETS_MY = [
    ApiPetSingle(id: "123", name: "Goldie", kind: .Dog, image: "", birthDate: Date(), healthLog: 8, createdAt: Date(), updatedAt: Date())
]

struct DisplayMyPets: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DispalyMyPets_Previews: PreviewProvider {
    static var previews: some View {
        DisplayMyPets()
    }
}
