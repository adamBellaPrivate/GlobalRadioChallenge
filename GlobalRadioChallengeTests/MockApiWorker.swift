//
//  MockApiWorker.swift
//  GlobalRadioChallengeTests
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

public enum ApiPath {
    case initial
    case custom(String)
}

struct MockApiWorker: ApiWorkerProtocol {

    public typealias ResultCallback<Value> = (Result<Value>) -> Void

    private enum PrivateConstants {

         static let successStatusCode = 200
         static let baseURL = "http://localhost:8000/"

    }

    private let utils = ApiMockUtils()

    func initialRequest<T: Decodable>(with request: InitialApiRequest, responseType: T.Type) -> Observable<Result<T>> {
        return createCall(request, responseType: responseType)
    }

    func retrieveUUID<T: Decodable>(with request: RetrieveUUIDApiRequest, responseType: T.Type) -> Observable<Result<T>> {
        return createCall(request, responseType: responseType)
    }

}

private extension MockApiWorker {

    private var defaultHeaders: [String: String] {
        return ["Accept": "application/json"]
    }

    func createCall<U: ApiRequestProtocol, T: Decodable>(_ request: U, responseType: T.Type) -> Observable<Result<T>> {

        var dataOptional: Data?
        switch request.urlPath {
        case .initial:
           dataOptional = utils.loadMockInitialJson()
        default:
           dataOptional = utils.loadMockRetrieveUUIDJson()
        }

        guard let data = dataOptional else {
            return Observable.just(Result.failure(ErrorWorker.ApiError.invalidResponse))
        }

        do {
            let response = try JSONDecoder().decode(responseType, from: data)
            return Observable.just(Result.success(response))
        } catch {
            return Observable.just(Result.failure(ErrorWorker.ApiError.invalidResponse))
        }
    }

}
