//
//  CheckboxComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct UICheckbox: View {
    var label: String!
    @Binding var state: Bool
    
    var body: some View {
        Toggle(label, isOn: $state)
            .toggleStyle(.switch)
    }
}

struct UICheckbox_Previews: PreviewProvider {
    @State static var state = true

    static var previews: some View {
        UICheckbox(label: "Lorem ipsum dolor sit amet", state: $state)
        UICheckbox(label: "Lorem ipsum dolor sit amet", state: $state)
            .preferredColorScheme(.dark)
    }
}
