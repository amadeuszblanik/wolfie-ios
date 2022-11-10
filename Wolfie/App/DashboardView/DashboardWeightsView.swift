//
//  DashboardWeightsView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI
import Charts

struct DashboardWeightsView: View {
    var pet: ApiPetSingle

    @State private var isDeleteOpen = false;
    @StateObject var vm = ViewModel()
    
    var body: some View {
        VStack {
            if (vm.data.count >= 3) {
                VStack {
                    UISummary(averageValue: 19.80, unit: "kg", dateRange: DateInterval(start: Date(timeIntervalSinceNow: -213769420), end: Date()))
                        .padding(.bottom)
                    
                    Chart(vm.data.reversed()) {
                        LineMark(
                            x: .value("X", $0.date),
                            y: .value("Y", $0.raw)
                        )
                        PointMark(
                            x: .value("X", $0.date),
                            y: .value("Y", $0.raw)
                        )
                    }
                    .frame(height: UIScreen.main.bounds.height / 4.2)
                }
                .padding(.top)
                .padding(.horizontal)
            }
            
            List() {
                Section {
                    ForEach(vm.data) { data in
                        HStack {
                            Text(data.raw.formattedString)
                                .lineLimit(1)
                            
                            Spacer()
                            
                            Text(data.date.toFormattedWithTime())
                                .foregroundColor(Color(UIColor.secondaryLabel))
                                .lineLimit(1)
                        }
                        .swipeActions() {
                            Button(String(localized: "delete")) {
                                isDeleteOpen = true
                            }.tint(.red)
                        }
                        .alert(isPresented: $isDeleteOpen) {
                            Alert(
                                title: Text(String(localized: "action_delete_alert_title")),
                                message: Text(String(localized: "action_delete_alert_message")),
                                primaryButton: .destructive(Text(String(localized: "delete"))) {
                                    vm.delete(data.id)
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                } header: {
                    Text("KG")
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .cornerRadius(8)
        }
    }
}

struct DashboardWeightsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardWeightsView(pet: PET_GOLDIE)
        DashboardWeightsView(pet: PET_GOLDIE)
            .preferredColorScheme(.dark)
        
        DashboardWeightsView(pet: PET_GOLDIE, vm: DashboardWeightsView.ViewModel(data: [WEIGHT_142]))
        DashboardWeightsView(pet: PET_GOLDIE, vm: DashboardWeightsView.ViewModel(data: [WEIGHT_142]))
            .preferredColorScheme(.dark)
        
        DashboardWeightsView(pet: PET_GOLDIE, vm: DashboardWeightsView.ViewModel(data: [WEIGHT_142, WEIGHT_140, WEIGHT_138]))
        DashboardWeightsView(pet: PET_GOLDIE, vm: DashboardWeightsView.ViewModel(data: [WEIGHT_142, WEIGHT_140, WEIGHT_138]))
            .preferredColorScheme(.dark)
    }
}
