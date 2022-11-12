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
    @Published var pets: [PetDB] = []
    
    init() {
        openRealm()
        getTests()
        getPets()
    }
    
    func clearAll() {
        if let localRealm = localRealm {
            try! localRealm.write {
                localRealm.deleteAll()
            }
        }
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
            debugPrint(error)
            sentryLog("Error while trying to open Realm")
        }
    }
    
//    Test
    func getTests() {
        if let localRealm = localRealm {
            let allTests = localRealm.objects(Test.self)
            
            tests = []
            allTests.forEach { test in
                tests.append(test)
            }
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
                debugPrint(error)
                sentryLog("Error while trying to add test to Realm")
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
                    debugPrint(error)
                    sentryLog("Error while trying to delete test from Realm")
                }
            }
        }
    }
    
//    Pets
    
    func getPets() {
        if let localRealm = localRealm {
            let allResults = localRealm.objects(PetDB.self)
            var next: [PetDB] = []
            
            allResults.forEach { value in
                next.append(value)
            }
            
            pets = next
        }
    }
    
    func addPet(_ pet: ApiPetSingle) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(PetDB.fromApi(data: pet))
                    getPets()
                }
            } catch {
                debugPrint(error)
                logErrorAdd("Pet")
            }
        }
    }
    
    func updatePet(_ id: String, data: ApiPetSingle) {
        if let localRealm = localRealm {
            let allResults = localRealm.objects(PetDB.self)

            if let dataDb = allResults.find(predicate: { result in result.id == id }) {
                do {
                    try localRealm.write {
                        dataDb.id = data.id
                        dataDb.name = data.name
                        dataDb.kind = data.kind
                        dataDb.microchip = data.microchip
                        dataDb.image = data.image
                        if let currentWeight = data.currentWeight {
                            dataDb.currentWeight = WeightValueDB.fromApi(data: currentWeight)
                        }
                        dataDb.birthDate = data.birthDate
                        dataDb.healthLog = data.healthLog
                        if let breed = data.breed {
                            dataDb.breed = BreedDB.fromApi(data: breed)
                        }
                        dataDb.createdAt = data.createdAt
                        dataDb.updatedAt = data.updatedAt
                        
                        getPets()
                    }
                } catch {
                    debugPrint(error)
                    logErrorUpdate("Pet")
                }
            }
        }
    }
    
    func deletPet(_ id: String) {
        if let localRealm = localRealm {
            let allResults = localRealm.objects(PetDB.self)

            if let result = allResults.find(predicate: { result in result.id == id }) {
                do {
                    try localRealm.write {
                        localRealm.delete(result)

                        getPets()
                    }
                } catch {
                    debugPrint(error)
                    logErrorDelete("Pet")
                }
            }
        }
    }
    
    private func logErrorAdd(_ id: String) {
        sentryLog("Error while trying to add \(id) to Realm")
    }
    
    private func logErrorUpdate(_ id: String) {
        sentryLog("Error while trying to update \(id) to Realm")
    }
    
    private func logErrorDelete(_ id: String) {
        sentryLog("Error while trying to delete \(id) from Realm")
    }
}
