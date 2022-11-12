//
//  SelectComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 08/11/2022.
//

import SwiftUI

struct SelectItem: Hashable, Identifiable {
    var label: String
    var id: String
}

struct UISelect: View {
    var label: String = "Picker label"
    var values: [SelectItem]
    var plain = false
    var state: Binding<String>?
    @State private var selectedDefault: String = ""
    
    private let listRowPadding: Double = 5 // This is a guess
    private let listRowMinHeight: Double = 45 // This is a guess
    private var listRowHeight: Double {
        max(listRowMinHeight, 20 + 2 * listRowPadding)
    }
    
    var body: some View {
        HStack{
            Picker(label, selection: state ?? $selectedDefault) {
                ForEach(values) { value in
                    Text(value.label)
                        .tag(value.id)
                        .font(.body)
                }
            }
        }
        .lineLimit(1)
        .pickerStyle(MenuPickerStyle())
        .frame(maxWidth: .infinity)
        .padding(plain ? 0 : 16)
        .foregroundColor(Color(.label))
        .background(plain ? nil : Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct UISelect_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                UISelect(label: "Weight units", values: WeightUnits.selectItemList)
                UISelect(label: "Weight units", values: WeightUnits.selectItemList, plain: true)
            }

            VStack {
                UISelect(label: "Weight units", values: WeightUnits.selectItemList)
                UISelect(label: "Weight units", values: WeightUnits.selectItemList, plain: true)
            }
            .preferredColorScheme(.dark)
        }
    }
}
