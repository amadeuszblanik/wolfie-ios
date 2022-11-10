//
//  InputDateComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI

struct UIInputDate: View {
    var label: String!
    @Binding var state: Date
    var error: String?
    var hint: String?
    var displayedComponents: DatePicker<Label>.Components = [.date, .hourAndMinute]
    let start = Date(timeIntervalSince1970: 0)
    let end = Date()
    
    var dateRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let startComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: self.start)
        let endComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: self.end)
        
        return calendar.date(from: startComponents)!...calendar.date(from: endComponents)!
    }
    
    var body: some View {
        VStack {
            DatePicker(
                label,
                selection: $state,
                in: dateRange,
                displayedComponents: displayedComponents
            )
            .foregroundColor(Color(.label))
            .cornerRadius(8)
            
            HStack(alignment: .top) {
                if ((error) != nil) {
                    Text(error!)
                        .font(.caption)
                        .foregroundColor(Color.red)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.trailing)
                        .padding(.bottom)
                }
                
                if ((hint) != nil) {
                    Text(hint!)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .topTrailing)
                        .padding(.leading)
                        .padding(.bottom)
                }
            }
        }
    }
}

struct UIInputDate_Previews: PreviewProvider {
    @State static var state = Date()

    static var previews: some View {
        VStack {
            UIInputDate(label: "Date", state: $state)
                .padding(.horizontal)
            
            UIInputDate(label: "Date", state: $state, error: "Wrong date")
                .padding(.horizontal)
            
            UIInputDate(label: "Date", state: $state, hint: "Date from the past")
                .padding(.horizontal)
            
            UIInputDate(label: "Date", state: $state, error: "Wrong date", hint: "Date from the past")
                .padding(.horizontal)
        }

        VStack {
            UIInputDate(label: "Date", state: $state)
                .padding(.horizontal)
            
            UIInputDate(label: "Date", state: $state, error: "Wrong date")
                .padding(.horizontal)
            
            UIInputDate(label: "Date", state: $state, hint: "Date from the past")
                .padding(.horizontal)
            
            UIInputDate(label: "Date", state: $state, error: "Wrong date", hint: "Date from the past")
                .padding(.horizontal)
        }
        .preferredColorScheme(.dark)
    }
}
