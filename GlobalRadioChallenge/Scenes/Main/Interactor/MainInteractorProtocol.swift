//
//  MainInteractorProtocol.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import RxCocoa
import RxSwift
import Alamofire

protocol MainInteractorProtocol {

    func requestUUID() -> Observable<Result<RetrieveUUIDApiResponse>>
    func saveFetchedTimes(count: Int)
    func getFetchedTimes() -> Int

}
