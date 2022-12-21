//
//  SkeletonComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import SwiftUI

struct UISkeleton: View {
    var body: some View {
        Rectangle()
            .fill(
            LinearGradient(
                gradient: .init(colors: [Color(UIColor.tertiaryLabel), Color(UIColor.quaternaryLabel)]),
                startPoint: .leading,
                endPoint: .trailing
            )
        )
    }
}

struct UISkeleton_Previews: PreviewProvider {
    static var previews: some View {
        UISkeleton()
        UISkeleton()
            .preferredColorScheme(.dark)

        UISkeleton()
            .frame(width: .infinity, height: 45)
        UISkeleton()
            .frame(width: .infinity, height: 45)
            .preferredColorScheme(.dark)
    }
}
