//
//  PetForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import SwiftUI

struct PetForm: View {
    var onSuccess: () -> ()
    
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
                        UISelectSearch(
                            label: String(localized: "breed"),
                            values: vm.breedsSelectedItem,
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
                        vm.id != nil ? vm.update() : vm.create()
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
            PetForm(onSuccess: onSuccess)
        }.sheet(isPresented: $isOpen) {
            PetForm(onSuccess: onSuccess)
        }
        VStack {
            PetForm(onSuccess: onSuccess)
        }.sheet(isPresented: $isOpen) {
            PetForm(onSuccess: onSuccess)
        }
        .preferredColorScheme(.dark)
        
        VStack {
            PetForm(onSuccess: onSuccess, vm: PetForm.ViewModel(pet: PET_GOLDIE))
        }.sheet(isPresented: $isOpen) {
            PetForm(onSuccess: onSuccess, vm: PetForm.ViewModel(pet: PET_GOLDIE))
        }
        VStack {
            PetForm(onSuccess: onSuccess, vm: PetForm.ViewModel(pet: PET_GOLDIE))
        }.sheet(isPresented: $isOpen) {
            PetForm(onSuccess: onSuccess, vm: PetForm.ViewModel(pet: PET_GOLDIE))
        }
        .preferredColorScheme(.dark)
    }
}
