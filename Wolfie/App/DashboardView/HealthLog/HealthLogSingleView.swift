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
    @StateObject var vm = ViewModel()
    
    var body: some View {
        List {
            Section {
                HealthLogSingleItemView(
                    label: String(localized: "kind"),
                    value: vm.data.kind.localized
                )

                HealthLogSingleItemView(
                    label: String(localized: "date"),
                    value: vm.data.date.asDate.asFormattedMedium
                )

                HealthLogSingleItemView(
                    label: String(localized: "medicines"),
                    value: vm.data.medicinesAsString.isEmpty ? "—" : vm.data.medicinesAsString
                )

                HealthLogSingleItemView(
                    label: String(localized: "veterinary"),
                    value: vm.data.veterinary ?? "—"
                )

                HealthLogSingleItemView(
                    label: String(localized: "diagnosis"),
                    value: vm.data.diagnosis ?? "—"
                )

                HealthLogSingleItemView(
                    label: String(localized: "next_visit"),
                    value: vm.data.nextVisit?.asFormattedWithTime ?? "—"
                )

                HealthLogSingleItemView(
                    label: String(localized: "description"),
                    value: vm.data.description ?? "—"
                )

                HealthLogSingleItemView(
                    label: String(localized: "added_by"),
                    value: vm.data.addedBy.fullName
                )
            } header: {
                Text(String(localized: "sample_data"))
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct HealthLogSingleView_Previews: PreviewProvider {
    static var previews: some View {
        HealthLogSingleView(vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_0))
        HealthLogSingleView(vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_0))
            .preferredColorScheme(.dark)

        HealthLogSingleView(vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_1))
        HealthLogSingleView(vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_1))
            .preferredColorScheme(.dark)

        HealthLogSingleView(vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_2))
        HealthLogSingleView(vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_2))
            .preferredColorScheme(.dark)
        
        NavigationView {
            HealthLogSingleView(vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_0))
        }
        NavigationView {
            HealthLogSingleView(vm: HealthLogSingleView.ViewModel(data: HEALTHLOG_0))
        }
            .preferredColorScheme(.dark)
    }
}
