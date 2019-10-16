//
//  ApiWorker.swift
//  GlobalRadioChallenge
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

struct ApiWorker: ApiWorkerProtocol {

    public typealias ResultCallback<Value> = (Result<Value>) -> Void

    private enum PrivateConstants {

         static let successStatusCode = 200
         static let baseURL = "http://localhost:8000/"

    }

    func initialRequest<T: Decodable>(with request: InitialApiRequest, responseType: T.Type) -> Observable<Result<T>> {
        return createCall(request, responseType: responseType)
    }

    func retrieveUUID<T: Decodable>(with request: RetrieveUUIDApiRequest, responseType: T.Type) -> Observable<Result<T>> {
        return createCall(request, responseType: responseType)
    }

}

private extension ApiWorker {

    private var defaultHeaders: [String: String] {
        return ["Accept": "application/json"]
    }

    func createCall<U: ApiRequestProtocol, T: Decodable>(_ request: U, responseType: T.Type) -> Observable<Result<T>> {

        var urlString = PrivateConstants.baseURL
        switch request.urlPath {
        case .custom(let url):
            urlString = url
        default: break
        }

        guard let baseUrl = try? urlString.asURL() else {
            return Observable.just(Result.failure(ErrorWorker.ApiError.invalidApiURL))
        }

        return RxAlamofire.requestData(request.method, baseUrl, parameters: .none, headers: defaultHeaders).map { (urlResponse, data) -> Result<T> in
            #if DEBUG
                NSLog("End WS call \(baseUrl) with status code: \(urlResponse.statusCode)")
            #endif
            if PrivateConstants.successStatusCode == urlResponse.statusCode {
                do {
                    let response = try JSONDecoder().decode(responseType, from: data)
                    return Result.success(response)
                } catch {
                    return Result.failure(ErrorWorker.ApiError.invalidResponse)
                }
            } else {
                return Result.failure(ErrorWorker.ApiError.businessError(urlResponse.statusCode))
            }
        }.catchError({ error -> Observable<Result<T>> in
            return Observable.just(Result.failure(error))
        })
    }
}
