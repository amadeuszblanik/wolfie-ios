//
//  WeightForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI

struct WeightForm: View {
    enum FocusField: Hashable {
        case date
        case time
        case weight
    }
    
    @StateObject var vm: ViewModel
    @FocusState private var focusedField: FocusField?

    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    #if DEBUG
                    HStack(alignment: .firstTextBaseline) {
                        Text("Id")
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        
                        Spacer()
                        
                        Text(vm.id ?? "—")
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                    
                    HStack(alignment: .firstTextBaseline) {
                        Text("PetId")
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        
                        Spacer()
                        
                        Text(vm.pet.id)
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                    #endif
                    
                    HStack {
                        DatePicker(String(localized: "date"), selection: $vm.state.date, in: vm.dateRange, displayedComponents: [.date])
                            .focused($focusedField, equals: .date)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                    
                    HStack {
                        DatePicker(
                            String(localized: "time"),
                            selection: $vm.state.date,
                            in: vm.dateRange,
                            displayedComponents: [.hourAndMinute]
                        )
                            .focused($focusedField, equals: .time)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))

                    HStack {
                        Text(vm.weightUnit.rawValue.lowercased())
                            .foregroundColor(Color(UIColor.secondaryLabel))

                        TextField("", value: $vm.state.weight, formatter: numberFormatter(.decimal, zeroSymbol: ""))
                            .textFieldStyle(PlainTextFieldStyle())
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .weight)
                            .multilineTextAlignment(.trailing)
                            .onAppear {
                                self.focusedField = .weight
                            }
                        
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
                .scrollContentBackground(.hidden)
                .cornerRadius(8)
                .disabled(vm.isLoading)
                .overlay {
                    if vm.isLoading {
                        Color(white: 0, opacity: 0.75)
                        ProgressView()
                            .tint(.white)
                    }
                }
                
                Spacer()
            }
            .navigationTitle(String(localized: vm.id != nil ? "weight_form_header_edit" : "weight_form_header_add"))
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

struct WeightForm_Previews: PreviewProvider {
    static func onSuccess() {
        print("Success")
    }
    static var pet = PetDB.fromApi(data: PET_GOLDIE)
    static var weight = WeightValueDB.fromApi(data: WEIGHT_142, petId: PET_GOLDIE.id)
    @State static var isOpen = true
    
    static var previews: some View {
        VStack {
            WeightForm(vm: WeightForm.ViewModel(pet: pet, onSuccess: onSuccess))
        }.sheet(isPresented: $isOpen) {
            WeightForm(vm: WeightForm.ViewModel(pet: pet, onSuccess: onSuccess))
        }
        VStack {
            WeightForm(vm: WeightForm.ViewModel(pet: pet, onSuccess: onSuccess))
        }.sheet(isPresented: $isOpen) {
            WeightForm(vm: WeightForm.ViewModel(pet: pet, onSuccess: onSuccess))
        }
        .preferredColorScheme(.dark)

        VStack {
            WeightForm(vm: WeightForm.ViewModel(pet: pet, weight: weight, onSuccess: onSuccess))
        }.sheet(isPresented: $isOpen) {
            WeightForm(vm: WeightForm.ViewModel(pet: pet, weight: weight, onSuccess: onSuccess))
        }
        VStack {
            WeightForm(vm: WeightForm.ViewModel(pet: pet, weight: weight, onSuccess: onSuccess))
        }.sheet(isPresented: $isOpen) {
            WeightForm(vm: WeightForm.ViewModel(pet: pet, weight: weight, onSuccess: onSuccess))
        }
        .preferredColorScheme(.dark)
    }
}
