//
//  FeedbackForm.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 30/11/2022.
//

import SwiftUI
import Sentry
import RealmSwift

struct FeedbackForm: View {

    struct FormState: Equatable {
        var comments = ""
        var email = ""
        var name = ""
    }

    var message: String
    @State var isSent = false
    @State var state = FormState()

    var comments: Binding<String> {
        Binding(
            get: { state.comments.count > 0 ? state.comments: " " },
            set: { state.comments = $0 }
        )
    }

    @StateObject var realmDb = RealmManager()
    @ObservedResults(UserDB.self) var userDb

    var form: some View {
        Group {
            List {
                HStack {
                    Text(String(localized: "name"))

                    TextField("", text: $state.name)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(UIColor.label))
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))

                HStack {
                    Text(String(localized: "email"))

                    TextField("", text: $state.email)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color(UIColor.label))
                        .keyboardType(.emailAddress)
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))

                HStack(alignment: .firstTextBaseline) {
                    Text(String(localized: "comment"))

                    TextEditor(text: comments)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color(UIColor.label))
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))

                HStack(alignment: .firstTextBaseline) {
                    Text(String(localized: "error_details"))

                    Text(message)
                        .multilineTextAlignment(.leading)
                        .disabled(true)
                }
                .listRowBackground(Color(UIColor.secondarySystemBackground))
            }
            .foregroundColor(Color(UIColor.secondaryLabel))
            .scrollContentBackground(.hidden)
            .navigationTitle(String(localized: "feedback_form_header"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button(String(localized: "submit")) {
                        withAnimation(.easeInOut) {
                            let eventId = SentrySDK.capture(message: message)

                            let userFeedback = UserFeedback(eventId: eventId)
                            userFeedback.comments = state.comments
                            userFeedback.email = state.email
                            userFeedback.name = state.name
                            SentrySDK.capture(userFeedback: userFeedback)

                            self.isSent = true
                        }
                    }
                }
            }
        }
        .onAppear {
            if let user = userDb.first {
                state.name = user.fullName
                state.email = user.email
            }
        }
    }

    var success: some View {
        UISuccess()
    }

    var body: some View {
        NavigationView {
            if !isSent {
                form
                
            } else {
                success

            }
        }
    }
}

struct FeedbackForm_Previews: PreviewProvider {
    @State static var isOpen = true
    static var message = "FeedbackForm_Previews"

    static var previews: some View {
        FeedbackForm(message: message)
        .sheet(isPresented: $isOpen) {
            FeedbackForm(message: message)
        }

        FeedbackForm(message: message)
        .sheet(isPresented: $isOpen) {
            FeedbackForm(message: message)
        }
        .preferredColorScheme(.dark)
    }
}
