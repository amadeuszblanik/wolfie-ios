//
//  PetForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import SwiftUI

struct PetForm: View {
    var onSave: () -> ()
    var onDelete: () -> ()
    
    @State private var isDeleteOpen = false
    @StateObject var vm = ViewModel()
    @StateObject var realmDb = RealmManager()
    
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date(timeIntervalSince1970: 0))
        let endComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
        
        return calendar.date(from: startComponents)!...calendar.date(from: endComponents)!
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text(String(localized: "name"))
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        
                        TextField("", text: $vm.name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
//                        UIBreedSelect(
//                            label: String(localized: "breed"),
//                            plain: true,
//                            state: $vm.breed
//                        )
                        UIBreedSelect(
                            label: String(localized: "breed"),
                            plain: true,
                            state: $vm.breed
                        )
                    }
                    
                    HStack {
                        Text(String(localized: "microchip"))
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        
                        TextField("", text: $vm.microchip)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        DatePicker(
                            String(localized: "birthdate"),
                            selection: $vm.birthDate,
                            in: dateRange,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                    
                    if let id = vm.id {
                        UIButton(text: String(localized: "delete"), color: .red, fullWidth: true) {
                            isDeleteOpen = true
                        }
                        .alert(isPresented: $isDeleteOpen) {
                            Alert(
                                title: Text(String(localized: "action_delete_alert_title")),
                                message: Text(String(localized: "action_delete_alert_message")),
                                primaryButton: .destructive(Text(String(localized: "delete"))) {
                                    realmDb.deletPet(id)
                                    onDelete()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
            }
            .navigationTitle(String(localized: vm.id != nil ? "pet_form_header_edit" : "pet_form_header_add"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(String(localized: "save")) {
                        if let id = vm.id {
                            realmDb.updatePet(id, data: vm.save())
                        } else {
                            realmDb.addPet(vm.save())
                        }
                        onSave()
                    }
                }
            }
        }
    }
}

struct PetForm_Previews: PreviewProvider {
    @State static var isOpen = true
    static func onSuccess() {
        print("Success")
    }
    
    static var previews: some View {
        VStack {
            PetForm(onSave: onSuccess, onDelete: onSuccess)
        }.sheet(isPresented: $isOpen) {
            PetForm(onSave: onSuccess, onDelete: onSuccess)
        }
        VStack {
            PetForm(onSave: onSuccess, onDelete: onSuccess)
        }.sheet(isPresented: $isOpen) {
            PetForm(onSave: onSuccess, onDelete: onSuccess)
        }
        .preferredColorScheme(.dark)
        
        VStack {
            PetForm(onSave: onSuccess, onDelete: onSuccess, vm: PetForm.ViewModel(pet: PetDB.fromApi(data: PET_GOLDIE)))
        }.sheet(isPresented: $isOpen) {
            PetForm(onSave: onSuccess, onDelete: onSuccess, vm: PetForm.ViewModel(pet: PetDB.fromApi(data: PET_GOLDIE)))
        }
        VStack {
            PetForm(onSave: onSuccess, onDelete: onSuccess, vm: PetForm.ViewModel(pet: PetDB.fromApi(data: PET_GOLDIE)))
        }.sheet(isPresented: $isOpen) {
            PetForm(onSave: onSuccess, onDelete: onSuccess, vm: PetForm.ViewModel(pet: PetDB.fromApi(data: PET_GOLDIE)))
        }
        .preferredColorScheme(.dark)
    }
}
