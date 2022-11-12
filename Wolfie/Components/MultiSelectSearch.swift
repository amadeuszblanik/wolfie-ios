//
//  MultiSelectSearch.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI

struct UIMultiSelectSearch: View {
    var label: String!
    var values: [SelectItem]
    var plain = false
    @Binding var state: Set<String>
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
            
            Button(state.count.formatted()) {
                isOpen = true
            }
        }
        .sheet(isPresented: $isOpen) {
            NavigationView {
                VStack {
                    List(searchResults, id: \.id, selection: $state) { value in
                        HStack {
                            Text(value.label)

                            Spacer()

                            Text (value.id)
                                .font(.callout)
                                .foregroundColor(Color(UIColor.secondaryLabel))
                        }
                        .lineLimit(1)
                    }
                    .environment(\.editMode, .constant(.active))
                }
                .searchable(text: $query)
                .navigationTitle(label)
            }
        }
        .lineLimit(1)
        .frame(maxWidth: .infinity)
        .padding(plain ? 0 : 16)
        .foregroundColor(Color(.label))
        .background(plain ? nil : Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct UIMultiSelectSearch_Previews: PreviewProvider {
    @State static var selectedValue = Set<String>()
    
    static var values: [SelectItem] = [
        SelectItem(label: "English Pointer", id: "1"),
        SelectItem(label: "English Setter", id: "2"),
        SelectItem(label: "Giant Schnauzer", id: "181"),
        SelectItem(label: "Schnauzer", id: "182"),
        SelectItem(label: "Miniature Schnauzer", id: "183")
    ]
    
    static var previews: some View {
        VStack {
            UIMultiSelectSearch(
                label: "Select breed",
                values: values,
                state: $selectedValue
            )
            .padding(.bottom)
            
            UIMultiSelectSearch(
                label: "Select breed",
                values: values,
                plain: true,
                state: $selectedValue
            )
        }
        .padding(.horizontal)
        
        VStack {
            UIMultiSelectSearch(
                label: "Select breed",
                values: values,
                state: $selectedValue
            )
            .padding(.bottom)
            
            UIMultiSelectSearch(
                label: "Select breed",
                values: values,
                plain: true,
                state: $selectedValue
            )
        }
        .padding(.horizontal)
        .preferredColorScheme(.dark)
    }
}
