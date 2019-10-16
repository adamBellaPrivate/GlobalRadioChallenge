//
//  ApiWorkerProtocol.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol ApiWorkerProtocol {

    func initialRequest<T: Decodable>(with request: InitialApiRequest, responseType: T.Type) -> Observable<Result<T>>
    func retrieveUUID<T: Decodable>(with request: RetrieveUUIDApiRequest, responseType: T.Type) -> Observable<Result<T>>

}

protocol ApiRequestProtocol {

    var urlPath: ApiPath { get }
    var method: HTTPMethod { get }

}
