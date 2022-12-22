//
//  SkeletonComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 21/12/2022.
//

import SwiftUI

struct UISkeleton: View {
    @State var animationValue = false
    @State var startPoint: UnitPoint = .leading
    @State var endPoint: UnitPoint = .trailing

    var colors: [Color] = [Color(UIColor.tertiaryLabel), Color(UIColor.quaternaryLabel), Color(UIColor.tertiaryLabel)]

    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
            .onAppear {
                let animation = Animation.easeInOut(duration: 3)
                let repeated = animation.repeatForever(autoreverses: true)

                withAnimation(repeated) {
                    self.animationValue = false
                    self.startPoint = .trailing
                    self.endPoint = .leading
                }
            }
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
