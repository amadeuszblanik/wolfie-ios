//
//  DashboardWeightsView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI
import Charts
import RealmSwift

struct DashboardWeightsView: View {
    var pet: PetDB {
        didSet {
            print("🐕‍🦺 \(pet)")
        }
    }
    @StateObject var vm = ViewModel()
    @StateObject var realmDb = RealmManager()
    @ObservedResults(WeightValueDB.self) var weightDb

    var petWeightDb: Results<WeightValueDB> {
        weightDb
            .filter("petId == '\(pet.id)'").sorted(by: \.date, ascending: false)
    }

    var initialized: some View {
        ProgressView()
    }

    var fetching: some View {
        VStack {
            UISkeletonList(listRowBackground: Color(UIColor.secondarySystemBackground))
        }
    }

    var failed: some View {
        UIStatus(realmDb.petWeightsErrorMessage, onTryAgain: { realmDb.fetchWeights(petId: pet.id) })
            .padding(.horizontal)
    }

    var empty: some View {
        UIStatus(
            String(localized: "weight_empty"),
            icon: "sad-outline",
            color: Color(UIColor.label)
        )
            .fontWeight(.semibold)
    }

    var filled: some View {
        VStack {
            if petWeightDb.count >= 3 {
                UIWeightChart(data: petWeightDb)
                    .padding(.top)
                    .padding(.horizontal)
            }

            List {
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
                            .listRowBackground(Color(UIColor.secondarySystemBackground))
                            .swipeActions {
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
                        WeightForm(
                            vm: WeightForm.ViewModel(
                                pet: pet,
                                weight: selectedWeight,
                                onSuccess: { vm.selectedEditWeight = nil }
                            )
                        )
                    }
                }
            }
                .cornerRadius(8)
        }
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                switch realmDb.petWeightsStatus {
                case .initialized:
                    initialized
                        .frame(height: geo.size.height - 50)
                        .onAppear {
                        realmDb.fetchWeights(petId: pet.id)
                    }
                case .fetching:
                    fetching
                        .frame(height: geo.size.height - 50)
                case .success:
                    if petWeightDb.isEmpty {
                        empty
                            .frame(height: geo.size.height - 50)
                    } else {
                        filled
                            .frame(height: geo.size.height - 50)
                    }
                case .failed:
                    failed
                        .frame(height: geo.size.height - 50)
                }
            }
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .frame(width: geo.size.width - 5, height: geo.size.height - 50, alignment: .center)
                .refreshable {
                realmDb.fetchWeights(petId: pet.id)
            }
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
