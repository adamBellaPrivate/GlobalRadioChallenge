//
//  MainInteractor.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class MainInteractor {

    private let apiWorker: ApiWorkerProtocol
    private let errorWorker = ErrorWorker()
    private let userDefaultsWorker: UserDefaultsWorkerProtocol

    init(apiWorker: ApiWorkerProtocol,
         userDefaultsWorker: UserDefaultsWorkerProtocol) {
        self.apiWorker = apiWorker
        self.userDefaultsWorker = userDefaultsWorker
    }

}

extension MainInteractor: MainInteractorProtocol {

    func saveFetchedTimes(count: Int) {
        userDefaultsWorker.saveFetchedTimes(count: count)
    }

    func getFetchedTimes() -> Int {
        return userDefaultsWorker.getFetchedTimes()
    }

    func requestUUID() -> Observable<Result<RetrieveUUIDApiResponse>> {
        return apiWorker.initialRequest(with: InitialApiRequest(), responseType: InitialApiResponse.self)
            .flatMapLatest({ [weak self] result -> Observable<Result<RetrieveUUIDApiResponse>> in
                switch result {
                case .success(let response):
                    if let self = self {
                        let request = RetrieveUUIDApiRequest(urlPath: ApiPath.custom(response.nextPath))
                        return self.apiWorker.retrieveUUID(with: request, responseType: RetrieveUUIDApiResponse.self)
                    } else {
                        return Observable.just(Result.failure(ErrorWorker.ApiError.unknown))
                    }
                case .failure(let error):
                    return Observable.just(Result.failure(error))
                }
            })
    }

}
