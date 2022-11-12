//
//  ListSelection.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI

struct ListSelection: View {
    struct Ocean: Identifiable, Hashable {
        let name: String
        let id = UUID()
    }

    private var oceans = [
        Ocean(name: "Pacific"),
        Ocean(name: "Atlantic"),
        Ocean(name: "Indian"),
        Ocean(name: "Southern"),
        Ocean(name: "Arctic")
    ]

    @State private var multiSelection = Set<UUID>()

    var body: some View {
        NavigationView {
            List(oceans, selection: $multiSelection) {
                Text($0.name)
            }
            .navigationTitle("Oceans")
            .environment(\.editMode, .constant(.active))
        }
        Text("\(multiSelection.count) selections")
    }
}

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
        ListSelection()
    }
}
