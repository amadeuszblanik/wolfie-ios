//
//  GuestView.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 07/11/2022.
//

import SwiftUI

struct GuestView: View {
    @State private var selectedView: GuestViews?

    var body: some View {
        NavigationSplitView {
            VStack {
                Image("logo")
                    .resizable()
                    .scaleEffect()
                    .frame(width: 150, height: 150)
                    .padding()

                Spacer()

                Text(String(localized: "guest_view_header"))
                    .font(.title)
                    .padding(.bottom, 1)
                Text(String(localized: "app_name"))
                    .font(.title2)
                    .padding(.bottom)

                Spacer()

                List(selection: $selectedView) { }
                    .listStyle(.plain)
                    .frame(height: 0)

                ForEach(GuestViews.allCases.reversed(), id: \.self) { guestView in
                    UIButton(
                        text: guestView.localized,
                        fullWidth: true,
                        outline: guestView == GuestViews.allCases.reversed().last
                    ) {
                        selectedView = guestView
                    }
                }
                UISignInWithApple()
            }
                .padding()
        } detail: {
            if let guestView = selectedView {
                switch guestView {
                case GuestViews.signIn:
                    SignInView()
                case GuestViews.signUp:
                    SignUpView(selectedView: $selectedView)
                }
            } else {
                ProgressView()
            }
        }
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct GuestView_Previews: PreviewProvider {
    static var previews: some View {
        GuestView()
        GuestView()
            .preferredColorScheme(.dark)
    }
}
