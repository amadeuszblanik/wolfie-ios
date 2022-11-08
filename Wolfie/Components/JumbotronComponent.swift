//
//  JumbotronComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct UIJumbotron: View {
    var header: String!
    var subHeader: String!
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.title)
                .padding(.bottom, 2)
            
            Text(subHeader)
                .font(.title3)
        }
        .padding()
        .padding(.bottom, 15)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct UIJumbotron_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UIJumbotron(header: String(localized: "sign_in_header"), subHeader: String(localized: "sign_in_sub_header"))
            
            Spacer()
        }
        
        VStack {
            UIJumbotron(header: String(localized: "sign_in_header"), subHeader: String(localized: "sign_in_sub_header"))
            
            Spacer()
        }
            .preferredColorScheme(.dark)
    }
}
