//
//  HealthLogView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import SwiftUI
import RealmSwift

struct HealthLogView: View {
    var pet: PetDB
    @Binding var path: [DashboardViews]
    
    @State private var isDeleteOpen = false
    @StateObject var vm = ViewModel()
    @ObservedResults(HealthLogDB.self) var healthLogDb
    
    var petHealthLogDb: Results<HealthLogDB> { healthLogDb.filter("petId == '\(pet.id)'").sorted(by: \.date, ascending: false) }
    
    var filled: some View {
        Group {
            VStack {
                List{
                    Section {
                        ForEach(petHealthLogDb) { data in
                            Button {
                                print("Pressed on healthlog \(data.id)")
                                //                                path.append(.healthLogSingle)
                            } label: {
                                HStack {
                                    Text(data.kind.localized)
                                    
                                    Spacer()
                                    
                                    Text(data.date.asFormattedMedium)
                                        .foregroundColor(Color(UIColor.secondaryLabel))
                                    
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color(UIColor.secondaryLabel))
                                }
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
                        Text(String(localized: "health_log"))
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
            }
            .refreshable {
                RealmManager().fetchHealthLog(petId: pet.id)
            }
            .foregroundColor(Color(UIColor.label))
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .cornerRadius(8)
        }
    }
    
    var empty: some View {
        Group {
            VStack {
                Text(String(localized: "healt_log_empty"))
                    .padding(.bottom)
                UIButton(text: String(localized: "refresh")) {
                    RealmManager().fetchHealthLog(petId: pet.id)
                }
            }
        }.onAppear {
            RealmManager().fetchHealthLog(petId: pet.id)
        }
    }
    
    var body: some View {
        if petHealthLogDb.isEmpty {
            empty
        } else {
            filled
        }
    }
}

struct HealthLogView_Previews: PreviewProvider {
    static var pet = PetDB.fromApi(data: PET_GOLDIE)
    @State static var path: [DashboardViews] = [DashboardViews.healthLogSingle(pet: pet)]
    
    static var previews: some View {
        HealthLogView(pet: pet, path: $path)
        HealthLogView(pet: pet, path: $path)
            .preferredColorScheme(.dark)
    }
}
