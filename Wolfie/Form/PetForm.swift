//
//  PetForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import SwiftUI

struct PetForm: View {
    @StateObject var vm = ViewModel()

    var body: some View {
        VStack {
            UIJumbotron(
                header: String(localized: vm.id != nil ? "pet_form_header_edit" : "pet_form_header_add"),
                subHeader: vm.name
            )
            .padding(.bottom)
            
            VStack {
                UIInput(label: String(localized: "name"), state: $vm.name)
                    .padding(.bottom)
                
                UISelectSearch(label: String(localized: "breed"), values: vm.breeds, state: $vm.breed)
                    .padding(.bottom)
                
                UIInput(label: String(localized: "microchip"), state: $vm.microchip)
                    .padding(.bottom)
                
                UIInputDate(label: String(localized: "birthdate"), state: $vm.birthDate)
                
                Spacer()
                
                UIButton(
                    text: String(localized: vm.id != nil ? "update" : "add"),
                    fullWidth: true
                ) {
                    vm.createPet()
                }
            }
            .padding(.horizontal)
        }
    }
}

struct PetForm_Previews: PreviewProvider {
    static var previews: some View {
        PetForm()
        PetForm()
            .preferredColorScheme(.dark)
        PetForm(vm: PetForm.ViewModel(pet: PET_GOLDIE))
        PetForm(vm: PetForm.ViewModel(pet: PET_GOLDIE))
            .preferredColorScheme(.dark)
    }
}
