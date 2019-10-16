//
//  MainPresenter.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MainPresenter {

    private weak var view: MainDisplayLogic?
    private let interactor: MainInteractorProtocol

    init(_ resourceView: MainDisplayLogic?, interactor: MainInteractorProtocol) {
        view = resourceView
        self.interactor = interactor
    }

}

extension MainPresenter: MainPresenterProtocol {

    func onViewLoaded() {
        view?.onShowFetchedTime(count: interactor.getFetchedTimes())
    }

    func saveFetchedTimes(count: Int) {
        interactor.saveFetchedTimes(count: count)
    }

    func requestNewUUID() -> Driver<String> {
        return interactor.requestUUID().map({ result -> String in
            switch result {
            case .success(let response):
                return response.responseCode
            case .failure:
                return ""
            }
        })
        .asDriver(onErrorJustReturn: "")
        .filter({ !$0.isEmpty })
    }

}
