//
//  Test.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation
import RealmSwift

class Test: Object, ObjectKeyIdentifiable {
    @Persisted var id = 1
    @Persisted var title = ""
    @Persisted var subTitle: String?
    @Persisted var numberOfSections = 10
}
