//
//  WeightChartComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 22/12/2022.
//

import SwiftUI
import RealmSwift
import Charts

struct UIWeightChart: View {
    var data: Results<WeightValueDB>

    var averageValue: Double {
        let total = data.reduce(0) { $0 + $1.raw }

        return Double(total) / Double(data.count)
    }
    var firstEntryDate: Date {
        data.map { $0.date }.min()!
    }

    var lastEntryDate: Date {
        data.map { $0.date }.max()!
    }

    var minValue: Float {
        data.map { $0.raw }.min()!
    }

    var maxValue: Float {
        data.map { $0.raw }.max()!
    }

    var xValues: [Float] {
        stride(from: minValue, to: maxValue, by: (maxValue - minValue) / 5).map { $0 }
    }

    var body: some View {
        VStack {
            UISummary(
                averageValue: self.averageValue,
                unit: "kg",
                dateRange: DateInterval(start: firstEntryDate, end: lastEntryDate)
            )
                .padding(.bottom)

            Chart(data) {
                LineMark(
                    x: .value("X", $0.date),
                    y: .value("Y", $0.raw)
                )
                PointMark(
                    x: .value("X", $0.date),
                    y: .value("Y", $0.raw)
                )
            }
                .frame(height: UIScreen.main.bounds.height / 4.2)
        }
    }
}

struct UIWeightChart_Previews: PreviewProvider {
    static var previews: some View {
//        UIWeightChart()
        Text("@TODO")
    }
}
