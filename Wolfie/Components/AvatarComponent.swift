//
//  AvatarComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct UIAvatar: View {
    var url: String = ""
    var size = 120.0
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: (url.isEmpty ? "force-fail" : url))) { phase in
                if let image = phase.image {
                    image.resizable()
                } else if phase.error != nil {
                    Text("🐕‍🦺")
                        .font(.system(size: size / 2))
                } else {
                    ProgressView()
                }
            }
        }
        .frame(width: size, height: size)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(8)
        .clipped()
    }
}

struct AvatarComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UIAvatar(url: "https://uploads.wolfie.app/SU1HXzQ0MTUtMTY2NDczNTE0ODg4Mw.jpg")
            UIAvatar(url: "https://uploads.wolfie.app/SU1HXzQ0MTUtMTY2NDczNTE0ODg4Mw.jpx")
            UIAvatar(url: "")
            UIAvatar(url: "non-url")
        }
    }
}
