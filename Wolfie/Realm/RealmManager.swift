//
//  RealmManager.swift
//  Wolfie
//
//  Created by Amadeusz Blanik on 12/11/2022.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    
    @Published var tests: [Test] = []
    
    init() {
        openRealm()
        getTests()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion > 1 {
                    // Update
                }
            })
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        } catch {
            print("Error while trying to open Realm", error)
        }
    }
    
    func addTest() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTest = Test()
                    newTest.id = Int.random(in: 0...100)
                    newTest.title = "Lorem ipsum"
                    newTest.subTitle = "Lorem ipsum dolor sit amet"
                    newTest.numberOfSections = 20
                    
                    localRealm.add(newTest)
                    getTests()
                    print("Added to realm")
                }
            } catch {
                print("Error while adding data to Realm", error)
            }
        }
    }
    
    func getTests() {
        if let localRealm = localRealm {
            let allTests = localRealm.objects(Test.self)
            
            tests = []
            allTests.forEach { test in
                tests.append(test)
            }
        }
    }
    
    func deleteTest(id: Int) {
        if let localRealm = localRealm {
            let allTests = localRealm.objects(Test.self)

            if let test = allTests.find(predicate: { test in test.id == id }) {
                do {
                    try localRealm.write {
                        localRealm.delete(test)
                        tests = []
                        getTests()
                        print("Deleted from Realm")
                    }
                } catch {
                    print("Error while deleting data from Realm")
                }
            }
        }
    }
}
