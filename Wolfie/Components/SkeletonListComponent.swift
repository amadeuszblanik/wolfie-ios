//
//  SkeletonListComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 22/12/2022.
//

import SwiftUI

struct UISkeletonList: View {
    var elements: Int
    var listRowBackground: Color

    init(_ elements: Int = 10, listRowBackground: Color = Color(UIColor.systemBackground)) {
        self.elements = elements
        self.listRowBackground = listRowBackground
    }

    var body: some View {
        List {
            ForEach(0..<10) { _ in
                UISkeleton()
                    .frame(maxWidth: Double.random(in: 50..<250), maxHeight: 17)
                    .listRowBackground(listRowBackground)
            }
        }
    }
}

struct UISkeletonList_Previews: PreviewProvider {
    static var previews: some View {
        UISkeletonList()
        UISkeletonList()
            .preferredColorScheme(.dark)

        UISkeletonList(3, listRowBackground: Color(UIColor.secondarySystemBackground))
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
        UISkeletonList(3, listRowBackground: Color(UIColor.secondarySystemBackground))
            .preferredColorScheme(.dark)
            .listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
    }
}
