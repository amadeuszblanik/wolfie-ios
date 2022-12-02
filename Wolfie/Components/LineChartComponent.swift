//
//  LineChartComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 30/11/2022.
//

import SwiftUI
import Charts

struct LineChartEntry: Identifiable {
    var x: Date
    var y: Float

    var id: Float {
        return y
    }
}

struct LineChartComponent: View {
    var data: [LineChartEntry]
    @State var selectedView = "ALL" {
        didSet {
            updateStartingDate()
        }
    }
    var views = ["ALL", "Y", "M", "W", "D"]

    @State var startingDate = Date.distantPast
    @State var endingDate = Date.now

    var dataToRender: [LineChartEntry] {
        data.filter {
            $0.x >= startingDate && $0.x <= endingDate
        }
    }

    func updateStartingDate() {
        switch selectedView {
        case "D":
            endingDate = endingDate
            startingDate = endingDate - 1
        default:
            endingDate = endingDate
//            startingDate = .distantPast
        }
    }

    var body: some View {
        VStack {
            Picker("AA", selection: $selectedView) {
                ForEach(views, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom)

            Chart(dataToRender) {
                LineMark(
                    x: .value("X", $0.x),
                    y: .value("Y", $0.y)
                )
                PointMark(
                    x: .value("X", $0.x),
                    y: .value("Y", $0.y)
                )
            }
            .frame(height: UIScreen.main.bounds.height / 4.2)
            
            HStack {
                Button("👈") {
                    print("A")
                }
                Spacer()
                Button("👉") {
                    print("B")
                }
            }
            
            VStack {
                DatePicker(
                    "Starting date",
                    selection: $startingDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                
                DatePicker(
                    "Ending date",
                    selection: $endingDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
            }
            .onAppear {
                startingDate = data.map({ $0.x }).min()!
                endingDate = data.map({ $0.x }).max()!
            }
        }
    }
}

struct LineChartComponent_Previews: PreviewProvider {
    static var data = [
        LineChartEntry(x: Date(), y: 15.0),
        LineChartEntry(x: Date(timeIntervalSinceNow: -1000000), y: 14.8),
        LineChartEntry(x: Date(timeIntervalSinceNow: -2000000), y: 13.2),
        LineChartEntry(x: Date(timeIntervalSinceNow: -3000000), y: 13.2)
    ]

    static var previews: some View {
        LineChartComponent(data: data)
            .padding()
        LineChartComponent(data: data)
            .padding()
            .preferredColorScheme(.dark)
    }
}
