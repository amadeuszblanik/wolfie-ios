//
//  SelectSearchComponent.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 09/11/2022.
//

import SwiftUI

struct UISelectSearch: View {
    var label: String!
    var values: [SelectItem]
    @Binding var state: SelectItem?
    @State private var isOpen = false
    @State private var query = ""
    
    var searchResults: [SelectItem] {
        if (query.isEmpty) {
            return values
        }
        
        return values.filter { $0.label.contains(query) }
    }
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(Color(UIColor.secondaryLabel))
            
            Spacer()
            
            Button(state?.label ?? "——") {
                isOpen = true
            }
        }
        .sheet(isPresented: $isOpen) {
            NavigationView {
                VStack {
                    List(searchResults) { value in
                        Button {
                            state = value
                            isOpen = false
                        } label: {
                            HStack {
                                Text(value.label)

                                Spacer()

                                Text (value.id)
                                    .font(.callout)
                                    .lineLimit(1)
                                    .foregroundColor(Color(UIColor.secondaryLabel))
                            }
                            .foregroundColor(Color(UIColor.label))
                        }
                    }
                }
                .searchable(text: $query)
                .navigationTitle(label)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundColor(Color(.label))
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct UISelectSearch_Previews: PreviewProvider {
    @State static var selectedValue: SelectItem? = nil
    
    static var values: [SelectItem] = [
        SelectItem(label: "English Pointer", id: "1"),
        SelectItem(label: "English Setter", id: "2"),
        SelectItem(label: "Giant Schnauzer", id: "181"),
        SelectItem(label: "Schnauzer", id: "182"),
        SelectItem(label: "Miniature Schnauzer", id: "183")
    ]
    
    static var previews: some View {
        UISelectSearch(
            label: "Select breed",
            values: values,
            state: $selectedValue
        )
        
        UISelectSearch(
            label: "Select breed",
            values: values,
            state: $selectedValue
        )
            .preferredColorScheme(.dark)
    }
}
