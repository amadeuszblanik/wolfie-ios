//
//  HealthLogForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI

struct HealthLogForm: View {
    @StateObject var vm = ViewModel(pet: PET_GOLDIE)
    
    var isNextVisitAnimation: Binding<Bool> {
        .init(
            get: {
                vm.isNextVisit
            },
            set: { next in
                withAnimation {
                    vm.isNextVisit = next
                }
            }
        )
    }
    
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: vm.pet.birthDate)
        let endComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
        
        return calendar.date(from: startComponents)!...calendar.date(from: endComponents)!
    }
    
    var nextVisit: some View {
        Group {
            VStack {
                Toggle(String(localized: "next_visit"), isOn: isNextVisitAnimation)

                if (vm.isNextVisit) {
                    DatePicker("", selection: $vm.nextVisit, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Picker(String(localized: "kind"), selection: $vm.kind) {
                        ForEach(HealthLogKind.allCases, id: \.rawValue) { value in
                            Text(value.localized)
                                .tag(value)
                                .font(.body)
                        }
                    }
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))

                DatePicker(String(localized: "date"), selection: $vm.date, in: dateRange, displayedComponents: [.date])
                .listRowBackground(Color(UIColor.secondarySystemBackground))
                
                HStack {
                    Text(String(localized: "veterinary"))
                    
                    TextField("", text: $vm.veterinary)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(UIColor.label))
                }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                
                HStack {
                    Text(String(localized: "diagnosis"))
                    
                    TextField("", text: $vm.diagnosis)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(UIColor.label))
                }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                
                nextVisit
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                
                HStack {
                    Text(String(localized: "description"))
                    
                    TextField("", text: $vm.description)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(UIColor.label))
                }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
            }
            .foregroundColor(Color(UIColor.secondaryLabel))
            .scrollContentBackground(.hidden)
            .cornerRadius(8)
            .navigationTitle(String(localized: vm.id != nil ? "health_form_header_edit" : "health_form_header_add"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(String(localized: "save")) {
                        vm.id != nil ? vm.update() : vm.create()
                    }
                }
            }
        }
    }
}

struct HealthLogForm_Previews: PreviewProvider {
    @State static var isOpen = true
    
    static var previews: some View {
        VStack {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE))
        }
        .sheet(isPresented: $isOpen) {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE))
        }
        VStack {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE))
        }
        .sheet(isPresented: $isOpen) {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE))
        }
        .preferredColorScheme(.dark)

        VStack {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE, healthLog: HEALTHLOG_0))
        }
        .sheet(isPresented: $isOpen) {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE, healthLog: HEALTHLOG_0))
        }
        VStack {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE, healthLog: HEALTHLOG_0))
        }
        .sheet(isPresented: $isOpen) {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: PET_GOLDIE, healthLog: HEALTHLOG_0))
        }
        .preferredColorScheme(.dark)
    }
}
