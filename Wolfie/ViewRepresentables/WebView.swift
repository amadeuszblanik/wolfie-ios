//
//  WebView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Environment(\.colorScheme) private var colorScheme

    var url: String

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()

        let script = WKUserScript(
            source: "window.localStorage.clear()",
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )

        configuration.userContentController.addUserScript(script)

        let language = Locale.current.language.languageCode?.identifier ?? "en"
        let region = Locale.current.language.region?.identifier ?? "GB"

        let locale = "\(language)-\(region)"

        var localStorageData = [
            "accessToken": "",
            "selectedTheme": colorScheme == .dark ? "dark" : "light",
            "locale": locale,
            "ios": "true"
        ]

        if let data = KeychainService.standard.read(service: "access-token", account: "wolfie") {
            if let accessToken = String(data: data, encoding: .utf8) {
                localStorageData["accessToken"] = accessToken
            }
        }

        if JSONSerialization.isValidJSONObject(localStorageData),
            let data = try? JSONSerialization.data(withJSONObject: localStorageData, options: []),
            let value = String(data: data, encoding: .utf8) {
            let script = WKUserScript(
                source: "Object.assign(window.localStorage, \(value))",
                injectionTime: .atDocumentStart,
                forMainFrameOnly: true
            )

            configuration.userContentController.addUserScript(script)
        }

        configuration.userContentController.addUserScript(script)

        return WKWebView(frame: .zero, configuration: configuration)
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: URL(string: url)!)

        webView.load(request)
    }
}
