//
//  UserDefaultsWorkerProtocol.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

protocol UserDefaultsWorkerProtocol {

    func saveFetchedTimes(count: Int)
    func getFetchedTimes() -> Int
    func removeFetchedTimes()

}
