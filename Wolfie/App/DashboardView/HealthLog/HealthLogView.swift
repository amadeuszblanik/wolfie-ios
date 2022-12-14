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

    @StateObject var vm = ViewModel()
    @StateObject var realmDb = RealmManager()
    @ObservedResults(HealthLogDB.self) var healthLogDb
    
    var petHealthLogDb: Results<HealthLogDB> { healthLogDb.filter("petId == '\(pet.id)'").sorted(by: \.date, ascending: false) }
    
    var filled: some View {
        Group {
            VStack {
                List{
                    Section {
                        ForEach(petHealthLogDb) { data in
                            Button {
                                path.append(.healthLogSingle(pet: pet, healthLog: data))
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
                                    vm.selectedDeleteHealthLog = data
                                }.tint(.red)
                            }
                        }
                    } header: {
                        Text(String(localized: "health_log"))
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
                .alert(item: $vm.selectedDeleteHealthLog) { selectedDeleteHealthLog in
                    Alert(
                        title: Text(String(localized: "action_delete_alert_title")),
                        message: Text(String(localized: "action_delete_alert_message")),
                        primaryButton: .destructive(Text(String(localized: "delete"))) {
                            vm.delete(petId: pet.id, healthLogId: selectedDeleteHealthLog.id)
                        },
                        secondaryButton: .cancel()
                    )
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
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        Text(String(localized: "healt_log_empty"))
                            .padding(.bottom)
                    }
                    .frame(width: geometry.size.width)
                    .frame(minHeight: geometry.size.height)
                }
                .refreshable {
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
    static var healthLog = HealthLogDB.fromApi(data: HEALTHLOG_0, petId: pet.id)

    @State static var path: [DashboardViews] = [DashboardViews.healthLogSingle(pet: pet, healthLog: healthLog)]
    
    static var previews: some View {
        HealthLogView(pet: pet, path: $path)
        HealthLogView(pet: pet, path: $path)
            .preferredColorScheme(.dark)
    }
}
