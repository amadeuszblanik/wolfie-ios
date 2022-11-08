//
//  MainView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        if !vm.authenticated {
            GuestView()
        } else {
            VStack {
                Text("Signed in")
                Button("Sign off") {
                    vm.signOff()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
