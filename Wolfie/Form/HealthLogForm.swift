//
//  HealthLogForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI

struct HealthLogForm: View {
    @StateObject var vm: ViewModel

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
                    DatePicker("", selection: $vm.state.nextVisit, in: Date()..., displayedComponents: [.date, .hourAndMinute])
                }
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
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
                        Picker(String(localized: "kind"), selection: $vm.state.kind) {
                            ForEach(HealthLogKind.allCases, id: \.rawValue) { value in
                                Text(value.localized)
                                    .tag(value)
                                    .font(.body)
                            }
                        }
                    }
                        .listRowBackground(Color(UIColor.secondarySystemBackground))

                    DatePicker(String(localized: "date"), selection: $vm.state.date, in: dateRange, displayedComponents: [.date])
                        .listRowBackground(Color(UIColor.secondarySystemBackground))

                    UIMedicineSelect(
                        label: String(localized: "medicines"),
                        plain: true,
                        state: $vm.state.medicines
                    )
                        .listRowBackground(Color(UIColor.secondarySystemBackground))

                    HStack {
                        Text(String(localized: "additional_medicines_short"))

                        TextField("", text: $vm.state.additionalMedicines)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(UIColor.label))
                    }
                        .listRowBackground(Color(UIColor.secondarySystemBackground))

                    HStack {
                        Text(String(localized: "vet"))

                        TextField("", text: $vm.state.veterinary)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(UIColor.label))
                    }
                        .listRowBackground(Color(UIColor.secondarySystemBackground))

                    HStack {
                        Text(String(localized: "diagnosis"))

                        TextField("", text: $vm.state.diagnosis)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(UIColor.label))
                    }
                        .listRowBackground(Color(UIColor.secondarySystemBackground))

                    nextVisit
                        .listRowBackground(Color(UIColor.secondarySystemBackground))

                    HStack {
                        Text(String(localized: "description"))

                        TextField("", text: $vm.state.description)
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(Color(UIColor.label))
                    }
                        .listRowBackground(Color(UIColor.secondarySystemBackground))
                }
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    .scrollContentBackground(.hidden)
                    .cornerRadius(8)
                    .overlay {
                    if vm.isLoading {
                        Color(white: 0, opacity: 0.75)
                        ProgressView()
                            .tint(.white)
                    }
                }
                    .disabled(vm.isLoading)
            }
                .navigationTitle(String(localized: vm.id != nil ? "health_form_header_edit" : "health_form_header_add"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                ToolbarItem {
                    Button(String(localized: "save")) {
                        vm.id != nil ? vm.update() : vm.create()
                    }
                        .disabled(vm.isLoading)
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

struct HealthLogForm_Previews: PreviewProvider {
    static func onSuccess() {
        print("Success")
    }
    static var pet = PetDB.fromApi(data: PET_GOLDIE)
    static var healthLog = HealthLogDB.fromApi(data: HEALTHLOG_0, petId: pet.id)
    @State static var isOpen = true

    static var previews: some View {
        VStack {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: pet, onSuccess: onSuccess))
        }
            .sheet(isPresented: $isOpen) {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: pet, onSuccess: onSuccess))
        }
        VStack {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: pet, onSuccess: onSuccess))
        }
            .sheet(isPresented: $isOpen) {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: pet, onSuccess: onSuccess))
        }
            .preferredColorScheme(.dark)

        VStack {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: pet, data: healthLog, onSuccess: onSuccess))
        }
            .sheet(isPresented: $isOpen) {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: pet, data: healthLog, onSuccess: onSuccess))
        }
        VStack {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: pet, data: healthLog, onSuccess: onSuccess))
        }
            .sheet(isPresented: $isOpen) {
            HealthLogForm(vm: HealthLogForm.ViewModel(pet: pet, data: healthLog, onSuccess: onSuccess))
        }
            .preferredColorScheme(.dark)
    }
}
