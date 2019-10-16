//
//  MainPresenterProtocol.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxCocoa

protocol MainPresenterProtocol: class {

    func onViewLoaded()
    func saveFetchedTimes(count: Int)
    func requestNewUUID() -> Driver<String>

}
