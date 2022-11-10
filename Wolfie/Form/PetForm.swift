//
//  PetForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import SwiftUI

struct PetForm: View {
    @StateObject var vm = ViewModel()
    
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
                            values: vm.breeds,
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
                }
            }
            .navigationTitle(String(localized: vm.id != nil ? "pet_form_header_edit" : "pet_form_header_add"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(String(localized: "save")) {
                        vm.createPet()
                    }
                }
            }
        }
    }
}

struct PetForm_Previews: PreviewProvider {
    @State static var isOpen = true
    
    static var previews: some View {
        VStack {
            PetForm()
        }.sheet(isPresented: $isOpen) {
            PetForm()
        }
        VStack {
            PetForm()
        }.sheet(isPresented: $isOpen) {
            PetForm()
        }
        .preferredColorScheme(.dark)
        
        VStack {
            PetForm(vm: PetForm.ViewModel(pet: PET_GOLDIE))
        }.sheet(isPresented: $isOpen) {
            PetForm(vm: PetForm.ViewModel(pet: PET_GOLDIE))
        }
        VStack {
            PetForm(vm: PetForm.ViewModel(pet: PET_GOLDIE))
        }.sheet(isPresented: $isOpen) {
            PetForm(vm: PetForm.ViewModel(pet: PET_GOLDIE))
        }
        .preferredColorScheme(.dark)
    }
}
