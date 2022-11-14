//
//  LoaderFullScreen.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 14/11/2022.
//

import SwiftUI

struct UILoaderFullScreen: View {
    var body: some View {
        Color(white: 0, opacity: 0.75)
        ProgressView()
            .tint(.white)
    }
}

struct UILoaderFullScreen_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Lorem ipsum dolor sit amet")
                .font(.headline)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            UILoaderFullScreen()
        }
    }
}
