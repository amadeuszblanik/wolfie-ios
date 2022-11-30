//
//  MedicineSelectComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 30/11/2022.
//

import SwiftUI
import RealmSwift

struct UIMedicineSelect: View {
    var label: String?
    var plain = false
    @Binding var state: Set<String>

    @StateObject var realmDb = RealmManager()
    @ObservedResults(MedicineValueDB.self) var medicineDb

    func getValues() -> [SelectItem] {
        medicineDb.sorted(by: \.name).map { medicine in
            SelectItem(label: medicine.name, id: String(medicine.productNumber))
        }
    }

    var body: some View {
        UIMultiSelectSearch(
            label: label ?? String(localized: "medicine_select_label"),
            values: getValues(),
            plain: plain,
            state: $state
        )
        .onAppear {
            realmDb.fetchMedicines()
        }
    }
}

struct UIMedicineSelect_Previews: PreviewProvider {
    @State static var selectedValue = Set<String>()

    static var previews: some View {
        VStack {
            UIMedicineSelect(state: $selectedValue)
                .padding(.bottom)
            UIMedicineSelect(plain: true, state: $selectedValue)
        }
        .padding()

        VStack {
            UIMedicineSelect(state: $selectedValue)
                .padding(.bottom)
            UIMedicineSelect(plain: true, state: $selectedValue)
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}
