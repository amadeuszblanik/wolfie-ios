//
//  HealthLogView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 11/11/2022.
//

import SwiftUI

struct HealthLogView: View {
    @Binding var pet: ApiPetSingle
    @StateObject var vm = ViewModel()
    
    var filled: some View {
        Group {
            VStack {
                List{
                    Section {
                        ForEach(vm.data) { data in
                            Button {
                                print("Pressed on healthlog \(data.id)")
                            } label: {
                                HStack {
                                    Text(data.kind.localized)
                                    
                                    Spacer()
                                    
                                    Text(data.date.asDate.asFormattedMedium)
                                        .foregroundColor(Color(UIColor.secondaryLabel))
                                    
                                    Image(systemName: "chevron.right")
                                }
                            }
                        }
                    } header: {
                        Text(String(localized: "health_log"))
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
            }
            .foregroundColor(Color(UIColor.label))
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .cornerRadius(8)
        }
    }
    
    var empty: some View {
        Group {
            Text(String(localized: "healt_log_empty"))
        }
    }
    
    var body: some View {
        if vm.data.isEmpty {
            empty
        } else {
            filled
        }
    }
}

struct HealthLogView_Previews: PreviewProvider {
    @State static var pet = PET_GOLDIE
    
    static var previews: some View {
        HealthLogView(pet: $pet)
        HealthLogView(pet: $pet)
            .preferredColorScheme(.dark)

        HealthLogView(pet: $pet, vm: HealthLogView.ViewModel(data: [HEALTHLOG_0, HEALTHLOG_1, HEALTHLOG_2]))
        HealthLogView(pet: $pet, vm: HealthLogView.ViewModel(data: [HEALTHLOG_0, HEALTHLOG_1, HEALTHLOG_2]))
            .preferredColorScheme(.dark)
    }
}
