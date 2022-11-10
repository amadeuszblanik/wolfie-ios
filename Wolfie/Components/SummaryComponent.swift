//
//  SummaryComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 10/11/2022.
//

import SwiftUI

struct UISummary: View {
    var averageValue: Double
    var unit: String
    var dateRange: DateInterval
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(
                    String(
                        localized: "average",
                        comment: "Average"
                    ).uppercased()
                )
                .font(.callout)
                .fontWeight(.bold)
                
                HStack(alignment: .lastTextBaseline) {
                    Text(averageValue.formattedString)
                        .font(.largeTitle)
                    Text(String(unit))
                        .font(.title)
                }
                
                Text(dateRange.toFormattedString())
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(Color(UIColor.secondaryLabel))
            }

            Spacer()
        }
    }
}

struct UISummary_Previews: PreviewProvider {
    static var previews: some View {
        UISummary(averageValue: 19.80, unit: "kg", dateRange: DateInterval(start: Date(timeIntervalSinceNow: -213769420), end: Date()))
            .padding()
        UISummary(averageValue: 19.80, unit: "kg", dateRange: DateInterval(start: Date(timeIntervalSinceNow: -213769420), end: Date()))
            .padding()
            .preferredColorScheme(.dark)
    }
}
