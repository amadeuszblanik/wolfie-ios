//
//  DashboardWeightsView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI
import Charts
import RealmSwift

struct DashboardWeightsChartView: View {
    var data: Results<WeightValueDB>
    
    var averageValue: Double {
        let total = data.reduce(0) { $0 + $1.raw }
        
        return Double(total) / Double(data.count)
    }
    var firstEntryDate: Date {
        data.map { $0.date }.min()!
    }
    
    var lastEntryDate: Date {
        data.map { $0.date }.max()!
    }

    var body: some View {
        VStack {
            UISummary(averageValue: self.averageValue, unit: "kg", dateRange: DateInterval(start: firstEntryDate, end: lastEntryDate))
                .padding(.bottom)

            Chart(data) {
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
    }
}

struct DashboardWeightsView: View {
    var pet: PetDB

    @StateObject var vm = ViewModel()
    @StateObject var realmDb = RealmManager()
    @ObservedResults(WeightValueDB.self) var weightDb
    
    var petWeightDb: Results<WeightValueDB> { weightDb.filter("petId == '\(pet.id)'").sorted(by: \.date, ascending: false) }
    
    init(pet: PetDB) {
        self.pet = pet
        
        RealmManager().fetchWeights(petId: pet.id)
    }
    
    var empty: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Text(String(localized: "weight_empty"))
                        .padding(.bottom)
                }
                .frame(width: geometry.size.width)
                .frame(minHeight: geometry.size.height)
            }
            .refreshable {
                realmDb.fetchWeights(petId: pet.id)
            }
        }
    }
    
    var list: some View {
        Group {
            List() {
                Section {
                    ForEach(petWeightDb) { weight in
                        HStack {
                            Text(weight.raw.formattedString)
                                .lineLimit(1)
                            
                            Spacer()

                            Text(weight.date.toFormattedWithTime())
                                .foregroundColor(Color(UIColor.secondaryLabel))
                                .lineLimit(1)
                        }
                        .swipeActions() {
                            Button(String(localized: "delete")) {
                                vm.selectedDeleteWeight = weight
                            }.tint(.red)

                            Button(String(localized: "edit")) {
                                vm.selectedEditWeight = weight
                            }.tint(.accentColor)
                        }
                    }
                } header: {
                    Text(vm.units.rawValue.uppercased())
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))
                .alert(item: $vm.selectedDeleteWeight) { selectedWeight in
                    Alert(
                        title: Text(String(localized: "action_delete_alert_title")),
                        message: Text(String(localized: "action_delete_alert_message")),
                        primaryButton: .destructive(Text(String(localized: "delete"))) {
                            vm.delete(petId: pet.id, weight: selectedWeight)
                        },
                        secondaryButton: .cancel()
                    )
                }
                .sheet(item: $vm.selectedEditWeight) { selectedWeight in
                    VStack {
                        WeightForm(vm: WeightForm.ViewModel(
                            pet: pet,
                            weight: selectedWeight,
                            onSuccess: {
                                vm.selectedEditWeight = nil
                            }
                        ))
                    }
                }
            }
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .cornerRadius(8)
            .refreshable {
                realmDb.fetchWeights(petId: pet.id)
            }
        }
    }
    
    var body: some View {
        VStack {
            if (petWeightDb.count >= 3) {
                DashboardWeightsChartView(data: petWeightDb)
                .padding(.top)
                .padding(.horizontal)
            }
            
            if (petWeightDb.isEmpty) {
                empty
            } else {
                list
            }
        }
        .overlay {
            if vm.isLoading {
                UILoaderFullScreen()
            }
        }
        .alert(isPresented: $vm.isError) {
            Alert(
                title: Text(String(localized: "error_generic_title")),
                message: Text(vm.errorMessage)
            )
        }
    }
}

struct DashboardWeightsView_Previews: PreviewProvider {
    static var pet = PetDB.fromApi(data: PET_GOLDIE)
    static var pet2 = PetDB.fromApi(data: PET_TESTIE)
    
    static var previews: some View {
        DashboardWeightsView(pet: pet)
        DashboardWeightsView(pet: pet)
            .preferredColorScheme(.dark)
        
        DashboardWeightsView(pet: pet2)
        DashboardWeightsView(pet: pet2)
            .preferredColorScheme(.dark)
    }
}
