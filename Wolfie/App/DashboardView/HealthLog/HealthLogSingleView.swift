//
//  HealthLogSingleView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import SwiftUI
import RealmSwift

struct HealthLogSingleItemView: View {
    var label: String
    var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .foregroundColor(Color(UIColor.secondaryLabel))
            Text(value)
        }
    }
}

struct HealthLogSingleView: View {
    @ObservedResults(HealthLogDB.self) var healthLogDb

    var id: String
    
    var petHealthLogDb: HealthLogDB? { healthLogDb.find { $0.id == id } }
    
    var body: some View {
        if let data = petHealthLogDb {
            List {
                Section {
                    HealthLogSingleItemView(
                        label: String(localized: "kind"),
                        value: data.kind.localized
                    )
                    
                    HealthLogSingleItemView(
                        label: String(localized: "date"),
                        value: data.date.asFormattedMedium
                    )
                    
                    HealthLogSingleItemView(
                        label: String(localized: "medicines"),
                        value: data.medicinesAsString.isEmpty ? "—" : data.medicinesAsString
                    )
                    
                    HealthLogSingleItemView(
                        label: String(localized: "veterinary"),
                        value: data.veterinary ?? "—"
                    )
                    
                    HealthLogSingleItemView(
                        label: String(localized: "diagnosis"),
                        value: data.diagnosis ?? "—"
                    )
                    
                    HealthLogSingleItemView(
                        label: String(localized: "next_visit"),
                        value: data.nextVisit?.asFormattedWithTime ?? "—"
                    )
                    
                    HealthLogSingleItemView(
                        label: String(localized: "description"),
                        value: data.descriptionValue ?? "—"
                    )
                    
                    //                HealthLogSingleItemView(
                    //                    label: String(localized: "added_by"),
                    //                    value: data.addedBy.fullName
                    //                )
                } header: {
                    Text(String(localized: "sample_data"))
                }
            }
            .listStyle(InsetGroupedListStyle())
        } else {
            Text(String(localized: "error_generic_message"))
        }
    }
}

struct HealthLogSingleView_Previews: PreviewProvider {
    static var pet = PetDB.fromApi(data: PET_GOLDIE)

    static var previews: some View {
        HealthLogSingleView(id: HEALTHLOG_0.id)
        HealthLogSingleView(id: HEALTHLOG_0.id)
            .preferredColorScheme(.dark)

        HealthLogSingleView(id: HEALTHLOG_0.id)
        HealthLogSingleView(id: HEALTHLOG_0.id)
            .preferredColorScheme(.dark)

        HealthLogSingleView(id: HEALTHLOG_0.id)
        HealthLogSingleView(id: HEALTHLOG_0.id)
            .preferredColorScheme(.dark)
        
        NavigationView {
            HealthLogSingleView(id: HEALTHLOG_0.id)
        }
        NavigationView {
            HealthLogSingleView(id: HEALTHLOG_0.id)
        }
            .preferredColorScheme(.dark)
    }
}
