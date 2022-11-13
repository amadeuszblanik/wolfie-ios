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

    var pet: PetDB
    @StateObject var vm = ViewModel()
    @FocusState private var focusedField: FocusField?
    
    init(pet: PetDB, weight: WeightValueDB? = nil) {
        self.pet = pet
        vm.pet = pet

        vm.id = weight?.id ?? nil
        vm.date = weight?.date ?? Date()
        vm.weight = weight?.raw ?? nil
    }
    
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: pet.birthDate)
        let endComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: Date())
        
        return calendar.date(from: startComponents)!...calendar.date(from: endComponents)!
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        DatePicker(String(localized: "date"), selection: $vm.date, in: dateRange, displayedComponents: [.date])
                            .focused($focusedField, equals: .date)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))
                    
                    HStack {
                        DatePicker(
                            String(localized: "time"),
                            selection: $vm.date,
                            in: dateRange,
                            displayedComponents: [.hourAndMinute]
                        )
                            .focused($focusedField, equals: .time)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                    .listRowBackground(Color(UIColor.secondarySystemBackground))

                    HStack {
                        Text(vm.weightUnits.rawValue.lowercased())
                            .foregroundColor(Color(UIColor.secondaryLabel))

                        TextField("", value: $vm.weight, formatter: NumberFormatter())
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

                Spacer()
            }
            .navigationTitle(String(localized: vm.id != nil ? "weight_form_header_edit" : "weight_form_header_add"))
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

struct WeightForm_Previews: PreviewProvider {
    static var pet = PetDB.fromApi(data: PET_GOLDIE)
    static var weight = WeightValueDB.fromApi(data: WEIGHT_142, petId: PET_GOLDIE.id)
    @State static var isOpen = true
    
    static var previews: some View {
        VStack {
            WeightForm(pet: pet)
        }.sheet(isPresented: $isOpen) {
            WeightForm(pet: pet)
        }
        VStack {
            WeightForm(pet: pet)
        }.sheet(isPresented: $isOpen) {
            WeightForm(pet: pet)
        }
        .preferredColorScheme(.dark)

        VStack {
            WeightForm(pet: pet, weight: weight)
        }.sheet(isPresented: $isOpen) {
            WeightForm(pet: pet)
        }
        VStack {
            WeightForm(pet: pet, weight: weight)
        }.sheet(isPresented: $isOpen) {
            WeightForm(pet: pet)
        }
        .preferredColorScheme(.dark)
    }
}
