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
    @Published var petsStatus: ApiStatus = .initialized
    var petsErrorMessage: String?

    @Published var petWeightsStatus: ApiStatus = .initialized
    var petWeightsErrorMessage: String?

    @Published var petHealthLogsStatus: ApiStatus = .initialized
    var petHealthLogsErrorMessage: String?

    init() {
        openRealm()
        getTests()
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
            let config = Realm.Configuration(
                schemaVersion: 4,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 1 {
                        migration.deleteData(forType: PetDB.className())
                        migration.deleteData(forType: WeightValueDB.className())
                        migration.deleteData(forType: BreedDB.className())
                    }
                },
                deleteRealmIfMigrationNeeded: true
            )

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
    func fetchPets() {
        print("💿 Realm/Fetch Pets")
        self.petsStatus = .fetching
        self.petsErrorMessage = nil

        WolfieApi().getPetsMy { results in
            self.deletePetAll()

            switch results {
            case.success(let pets):
                pets.forEach { pet in
                    self.addPet(pet)
                }
                self.petsStatus = .success
            case .failure(let error):
                self.logErrorFetch("Pets \(error.localizedDescription)")
                self.petsStatus = .failed

                switch error {
                case.server(let message):
                    self.petsErrorMessage = message
                default:
                    self.petsErrorMessage = String(localized: "realm_pet_fetch_failed")
                }
            }
        }
    }

    func addPet(_ pet: ApiPetSingle) {
        if let localRealm = localRealm {

            do {
                try localRealm.write {
                    localRealm.add(PetDB.fromApi(data: pet), update: .all)
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
                            dataDb.currentWeight = WeightValueDB.fromApi(data: currentWeight, petId: data.id)
                        }
                        dataDb.birthDate = data.birthDate
                        dataDb.healthLog = data.healthLog
                        if let breed = data.breed {
                            dataDb.breed = BreedDB.fromApi(data: breed)
                        }
                        dataDb.createdAt = data.createdAt
                        dataDb.updatedAt = data.updatedAt
                    }
                } catch {
                    debugPrint(error)
                    logErrorUpdate("Pet")
                }
            }
        }
    }

    func deletePetAll() {
        print("💿 Realm/Delete PetAll")
        self.petWeightsStatus = .initialized

        if let localRealm = localRealm {
            let allResults = localRealm.objects(PetDB.self)

            do {
                try localRealm.write {
                    localRealm.delete(allResults)
                }
            } catch {
                debugPrint(error)
                logErrorDelete("PetAll")
            }
        }
    }

    func deletePet(_ id: String) {
        if let localRealm = localRealm {
            let allResults = localRealm.objects(PetDB.self)

            if let result = allResults.find(predicate: { result in result.id == id }) {
                do {
                    try localRealm.write {
                        localRealm.delete(result)
                    }
                } catch {
                    debugPrint(error)
                    logErrorDelete("Pet")
                }
            }
        }
    }

//    Weights
    func fetchWeights(petId: String) {
        print("💿 Realm/Fetch Weights")
        self.petWeightsStatus = .fetching
        self.petWeightsErrorMessage = nil

        WolfieApi().getPetsWeights(petId: petId) { results in
            self.deleteWeightAll(petId)

            switch results {
            case.success(let weights):
                weights.forEach { weight in
                    self.addWeight(weight, petId: petId)
                }
                self.petWeightsStatus = .success
            case .failure(let error):
                self.logErrorFetch("Weights")
                self.petWeightsStatus = .failed

                switch error {
                case.server(let message):
                    self.petWeightsErrorMessage = message
                default:
                    self.petWeightsErrorMessage = String(localized: "realm_pet_weights_fetch_failed")
                }
            }
        }
    }

    func addWeight(_ value: ApiWeightValue, petId: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(WeightValueDB.fromApi(data: value, petId: petId), update: .all)
                }
            } catch {
                debugPrint(error)
                logErrorAdd("Weight")
            }
        }
    }

    func deleteWeightAll(_ petId: String?) {
        print("💿 Realm/Delete WeightAll")

        if let localRealm = localRealm {
            let allResults = petId != nil
                ? localRealm.objects(WeightValueDB.self).filter("petId == '\(petId!)'")
            : localRealm.objects(WeightValueDB.self)

            do {
                try localRealm.write {
                    localRealm.delete(allResults)
                }
            } catch {
                debugPrint(error)
                logErrorDelete("WeightAll")
            }
        }
    }

    func deleteWeight(_ id: String) {
        if let localRealm = localRealm {
            let allResults = localRealm.objects(WeightValueDB.self)

            if let result = allResults.find(predicate: { result in result.id == id }) {
                do {
                    try localRealm.write {
                        localRealm.delete(result)
                    }
                } catch {
                    debugPrint(error)
                    logErrorDelete("Weight")
                }
            }
        }
    }

    //    Weights
    func fetchHealthLog(petId: String) {
        print("💿 Realm/Fetch HealthLogs")
        self.petHealthLogsStatus = .fetching
        self.petHealthLogsErrorMessage = nil

        WolfieApi().getPetsHealthLog(petId: petId) { results in
            self.deleteHealthLogAll(petId)

            switch results {
            case.success(let healthLogs):
                self.petHealthLogsStatus = .success
                healthLogs.forEach { healthLog in
                    self.addHealthLog(healthLog, petId: petId)
                }
            case .failure(let error):
                self.petHealthLogsStatus = .failed
                debugPrint(error)
                self.logErrorFetch("HealthLog")
                
                switch error {
                case.server(let message):
                    self.petHealthLogsErrorMessage = message
                default:
                    self.petHealthLogsErrorMessage = String(localized: "realm_pet_health_logs_fetch_failed")
                }
            }
        }
    }

    func addHealthLog(_ value: ApiHealthLogValue, petId: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(HealthLogDB.fromApi(data: value, petId: petId), update: .all)
                }
            } catch {
                debugPrint(error)
                logErrorAdd("HealthLog")
            }
        }
    }

    func deleteHealthLogAll(_ petId: String?) {
        print("💿 Realm/Delete WeightAll")
        if let localRealm = localRealm {
            let allResults = petId != nil
                ? localRealm.objects(HealthLogDB.self).filter("petId == '\(petId!)'")
                : localRealm.objects(HealthLogDB.self)

            do {
                try localRealm.write {
                    localRealm.delete(allResults)
                }
            } catch {
                debugPrint(error)
                logErrorDelete("WeightAll")
            }
        }
    }

    //    Breeds
    func fetchBreed() {
        print("💿 Realm/Fetch Breeds")

        WolfieApi().getBreeds { results in
            self.deleteBreedAll()

            switch results {
            case.success(let values):
                values.forEach { value in
                    self.addBreed(value)
                }
            case .failure(let error):
                debugPrint(error)
                self.logErrorFetch("Breed")
            }
        }
    }

    func addBreed(_ value: ApiBreed) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(BreedDB.fromApi(data: value), update: .all)
                }
            } catch {
                debugPrint(error)
                logErrorAdd("Breed")
            }
        }
    }

    func deleteBreedAll() {
        print("💿 Realm/Delete BreedAll")

        if let localRealm = localRealm {
            let allResults = localRealm.objects(BreedDB.self)

            do {
                try localRealm.write {
                    localRealm.delete(allResults)
                }
            } catch {
                debugPrint(error)
                logErrorDelete("BreedAll")
            }
        }
    }

    //    Config
    func fetchConfig(userEmail: String) {
        print("💿 Realm/Fetch Config")


        WolfieApi().getConfig { results in
            self.deleteConfigAll()

            switch results {
            case.success(let value):
                self.addConfig(value, userEmail: userEmail)
            case .failure(let error):
                debugPrint(error)
                self.logErrorFetch("Config")
            }
        }
    }

    func addConfig(_ value: ApiConfig, userEmail: String) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(ConfigDB.fromApi(data: value, userEmail: userEmail), update: .all)
                }
            } catch {
                debugPrint(error)
                logErrorAdd("Config")
            }
        }
    }

    func deleteConfigAll() {
        print("💿 Realm/Delete ConfigAll")

        if let localRealm = localRealm {
            let allResults = localRealm.objects(ConfigDB.self)

            do {
                try localRealm.write {
                    localRealm.delete(allResults)
                }
            } catch {
                debugPrint(error)
                logErrorDelete("ConfigAll")
            }
        }
    }

    //    User
    func fetchUser() {
        print("💿 Realm/Fetch User")

        WolfieApi().getProfile { results in
            self.deleteUserAll()

            switch results {
            case.success(let value):
                self.addUser(value)
            case .failure(let error):
                debugPrint(error)
                self.logErrorFetch("Profile")
            }
        }
    }

    func addUser(_ value: ApiUser) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(UserDB.fromApi(data: value), update: .all)
                }
            } catch {
                debugPrint(error)
                logErrorAdd("Profile")
            }
        }

        fetchConfig(userEmail: value.email)
    }

    func deleteUserAll() {
        print("💿 Realm/Delete UserAll")

        if let localRealm = localRealm {
            let allResults = localRealm.objects(UserDB.self)

            do {
                try localRealm.write {
                    localRealm.delete(allResults)
                }
            } catch {
                debugPrint(error)
                logErrorDelete("UserAll")
            }
        }
    }

    //    Medicines
    func fetchMedicines() {
        print("💿 Realm/Fetch Medicines")

        WolfieApi().getMedicines { results in
            self.deleteMedicinesAll()

            switch results {
            case.success(let values):
                values.forEach { value in
                    self.addMedicine(value)
                }
            case .failure(let error):
                debugPrint(error)
                self.logErrorFetch("Medicine")
            }
        }
    }

    func addMedicine(_ value: ApiShortMedicineValue) {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    localRealm.add(MedicineValueDB.fromShortApi(data: value), update: .all)
                }
            } catch {
                debugPrint(error)
                logErrorAdd("Medicine")
            }
        }
    }

    func deleteMedicinesAll() {
        print("💿 Realm/Fetch MedicinesAll")

        if let localRealm = localRealm {
            let allResults = localRealm.objects(MedicineValueDB.self)

            do {
                try localRealm.write {
                    localRealm.delete(allResults)
                }
            } catch {
                debugPrint(error)
                logErrorDelete("MedicinesAll")
            }
        }
    }

    private func logErrorFetch(_ id: String) {
        sentryLog("Error while trying to fetch \(id) to Realm")
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
