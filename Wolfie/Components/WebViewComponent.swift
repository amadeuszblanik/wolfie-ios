//
//  WebViewComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 13/11/2022.
//

import SwiftUI

struct UIWebView: View {
    var url: String
    var title = String(localized: "web_view_title")
    
    var body: some View {
        NavigationView {
            WebView(url: url)
            #if DEBUG
                .navigationTitle(title + " – " + url)
            #else
                .navigationTitle(title)
            #endif
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct UIWebView_Previews: PreviewProvider {
    static var url = "https://next.wolfie.app"
    @State static var isOpen = true
    
    static var previews: some View {
        UIWebView(url: url)
            .sheet(isPresented: $isOpen) {
                UIWebView(url: url)
            }
    }
}
