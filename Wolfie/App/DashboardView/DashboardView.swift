//
//  DashboardView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var vm = ViewModel();
    
    var list: some View {
        Group {
            VStack {
                UIJumbotron(
                    header: String(localized: "dashboard_header")
                )
                
                ScrollView {
                    ForEach(vm.petsList) { petSingle in
                        PetCardComponent(pet: petSingle)
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
            }
        }
    }
    
    var empty: some View {
        Group {
            VStack {
                UIJumbotron(
                    header: String(localized: "dashboard_header"),
                    subHeader: String(localized: "dashboard_sub_header_empty")
                )
                
                Spacer()

                UIButton(text: String(localized: "dashboard_empty_button"), fullWidth: true) {
                    print("Create new pet")
                }
                .padding()
            }
        }
    }
    
    var body: some View {
        if (vm.petsList.count <= 0) {
            empty
        } else {
            list
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
        DashboardView()
            .preferredColorScheme(.dark)
        DashboardView(vm: DashboardView.ViewModel(petList: [PET_GOLDIE]))
        DashboardView(vm: DashboardView.ViewModel(petList: [PET_GOLDIE]))
            .preferredColorScheme(.dark)
    }
}
