//
//  RealmPlayground.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import SwiftUI

struct RealmPlayground: View {
    @StateObject var realmDb = RealmManager()
    
    var body: some View {
        VStack {
            Text("Realm playground")
            
            ScrollView(.horizontal) {
                HStack {
                    Button("Add test") {
                        realmDb.addTest()
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Get tests") {
                        realmDb.getTests()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
            
            List(realmDb.tests, id: \.id) { test in
                VStack(alignment: .leading) {
                    Text(test.title)
                        .font(.title)
                    Text(test.subTitle ?? "—")
                        .font(.headline)
                    Text(test.numberOfSections.formatted())
                    
                    Button("Remove") {
                        realmDb.deleteTest(id: test.id)
                    }
                }
            }
        }
    }
}

struct RealmPlayground_Previews: PreviewProvider {
    static var previews: some View {
        RealmPlayground()
    }
}
