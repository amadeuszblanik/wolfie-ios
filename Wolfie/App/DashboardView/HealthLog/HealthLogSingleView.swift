//
//  HealthLogSingleView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import SwiftUI

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
    var data: HealthLogDB
    
    var body: some View {
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
    }
}

struct HealthLogSingleView_Previews: PreviewProvider {
    static var pet = PetDB.fromApi(data: PET_GOLDIE)
    static var healthLog0 = HealthLogDB.fromApi(data: HEALTHLOG_0, petId: pet.id)
    static var healthLog1 = HealthLogDB.fromApi(data: HEALTHLOG_1, petId: pet.id)
    static var healthLog2 = HealthLogDB.fromApi(data: HEALTHLOG_2, petId: pet.id)
    
    static var previews: some View {
        HealthLogSingleView(data: healthLog0)
        HealthLogSingleView(data: healthLog0)
            .preferredColorScheme(.dark)

        HealthLogSingleView(data: healthLog1)
        HealthLogSingleView(data: healthLog1)
            .preferredColorScheme(.dark)

        HealthLogSingleView(data: healthLog2)
        HealthLogSingleView(data: healthLog2)
            .preferredColorScheme(.dark)
        
        NavigationView {
            HealthLogSingleView(data: healthLog0)
        }
        NavigationView {
            HealthLogSingleView(data: healthLog0)
        }
            .preferredColorScheme(.dark)
    }
}
