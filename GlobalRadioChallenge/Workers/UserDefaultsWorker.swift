//
//  UserDefaultsWorker.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation

struct UserDefaultsWorker {

    enum Keys: String {
        case fetchedTimes
    }

    private let userDefaults: UserDefaults

    init(isTest: Bool = false) {
        switch isTest {
        case false:
          userDefaults = .standard
        case true:
          userDefaults = UserDefaults(suiteName: "Test")!
        }
    }

}

extension UserDefaultsWorker: UserDefaultsWorkerProtocol {

    func saveFetchedTimes(count: Int) {
        saveObject(count, key: .fetchedTimes)
    }

    func getFetchedTimes() -> Int {
        guard let count = getObject(.fetchedTimes) as? Int else { return 0 }
        return count
    }

    func removeFetchedTimes() {
        removeObject(.fetchedTimes)
    }
}

private extension UserDefaultsWorker {

    // MARK: - Base user Defaults

    func saveObject(_ object: Any, key: Keys) {
        userDefaults.set(object, forKey: key.rawValue)
        userDefaults.synchronize()
    }

    func getObject(_ key: Keys) -> Any? {
        return userDefaults.object(forKey: key.rawValue) as Any?
    }

    func removeObject(_ key: Keys) {
        userDefaults.removeObject(forKey: key.rawValue)
        userDefaults.synchronize()
    }

    func removeObjects(_ keys: [Keys]) {
        keys.forEach({ userDefaults.removeObject(forKey: $0.rawValue) })
        userDefaults.synchronize()
    }

}
