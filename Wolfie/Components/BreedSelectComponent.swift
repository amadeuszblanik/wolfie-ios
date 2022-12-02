//
//  BreedSelectComponen.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 23/11/2022.
//

import SwiftUI
import RealmSwift

struct UIBreedSelect: View {
    var label: String? = nil
    var plain = false
    @Binding var state: SelectItem?
    
    @StateObject var realmDb = RealmManager()
    @ObservedResults(BreedDB.self) var breedDb
    
    func getValues() -> [SelectItem] {
        breedDb.sorted(by: \.id, ascending: true).map { breed in
            SelectItem(label: breed.localizedName, id: String(breed.id))
        }
    }
    
    var body: some View {
        UISelectSearch(
            label: label ?? String(localized: "breed_select_label"),
            unselectedLabel: String(localized: "breed_mixed"),
            values: getValues(),
            plain: plain,
            allowDeselect: true,
            state: $state
        ).onAppear {
            realmDb.fetchBreed()
        }
    }
}

struct UIBreedSelect_Previews: PreviewProvider {
    @State static var selectedValue: SelectItem? = nil
    
    static var previews: some View {
        VStack {
            UIBreedSelect(state: $selectedValue)
                .padding(.bottom)
            UIBreedSelect(plain: true, state: $selectedValue)
        }
        .padding()
        
        VStack {
            UIBreedSelect(state: $selectedValue)
                .padding(.bottom)
            UIBreedSelect(plain: true, state: $selectedValue)
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}
