//
//  MainDevView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct MainDevView: View {
    @State var isGuestViewActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Development mode")
                    .font(.largeTitle)
                
                List {
                    NavigationLink(
                        destination: GuestView(),
                        isActive: $isGuestViewActive
                    ) {
                        Button("GuestView") {
                            isGuestViewActive = true;
                        }
                    }
                }
            }
        }
    }
}

struct MainDevView_Previews: PreviewProvider {
    static var previews: some View {
        MainDevView()
    }
}
