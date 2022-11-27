//
//  PetForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import SwiftUI

struct PetForm: View {
    @State private var isDeleteOpen = false
    @StateObject var vm: ViewModel
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

                    if vm.id != nil {
                        UIButton(text: String(localized: "delete"), color: .red, fullWidth: true) {
                            isDeleteOpen = true
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
                    .disabled(vm.isInvalid || vm.isLoading)
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
}

struct PetForm_Previews: PreviewProvider {
    @State static var isOpen = true
    static var pet = PetDB.fromApi(data: PET_GOLDIE)
    static func onSuccess() {
        print("Success")
    }

    static var previews: some View {
        VStack {
            PetForm(vm: PetForm.ViewModel(onSave: onSuccess, onDelete: onSuccess))
        }.sheet(isPresented: $isOpen) {
            PetForm(vm: PetForm.ViewModel(onSave: onSuccess, onDelete: onSuccess))
        }
        VStack {
            PetForm(vm: PetForm.ViewModel(onSave: onSuccess, onDelete: onSuccess))
        }.sheet(isPresented: $isOpen) {
            PetForm(vm: PetForm.ViewModel(onSave: onSuccess, onDelete: onSuccess))
        }
            .preferredColorScheme(.dark)

        VStack {
            PetForm(vm: PetForm.ViewModel(pet: pet, onSave: onSuccess, onDelete: onSuccess))
        }.sheet(isPresented: $isOpen) {
            PetForm(vm: PetForm.ViewModel(pet: pet, onSave: onSuccess, onDelete: onSuccess))
        }
        VStack {
            PetForm(vm: PetForm.ViewModel(pet: pet, onSave: onSuccess, onDelete: onSuccess))
        }.sheet(isPresented: $isOpen) {
            PetForm(vm: PetForm.ViewModel(pet: pet, onSave: onSuccess, onDelete: onSuccess))
        }
            .preferredColorScheme(.dark)
    }
}
