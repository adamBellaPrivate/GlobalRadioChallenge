//
//  GlobalRadioChallengeTests.swift
//  GlobalRadioChallengeTests
//
//  Created by Adam Bella on 10/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import Alamofire

@testable import GlobalRadioChallenge

class GlobalRadioChallengeTests: XCTestCase {

    private let userDefaultsWorker: UserDefaultsWorkerProtocol = UserDefaultsWorker(isTest: true)
    private var interactor: MainInteractorProtocol?
    private var presenter: MainPresenterProtocol?
    private let errorWorker = ErrorWorker()
    private var disposeBag = DisposeBag()

    override func setUp() {
        userDefaultsWorker.removeFetchedTimes()
        interactor = MainInteractor(apiWorker: MockApiWorker(), userDefaultsWorker: userDefaultsWorker)
        XCTAssertNotNil(interactor)
        presenter = MainPresenter(.none, interactor: interactor!)
        XCTAssertNotNil(presenter)
    }

    func testUserDefaults() {
        XCTAssertEqual(0, userDefaultsWorker.getFetchedTimes(), "USER_DEFAULTS: First request")
        userDefaultsWorker.saveFetchedTimes(count: 12)
        XCTAssertEqual(12, userDefaultsWorker.getFetchedTimes(), "USER_DEFAULTS: Saved and Read immediately")
    }

    func testMainInteractor() {
        XCTAssertNotNil(interactor)

        interactor!.saveFetchedTimes(count: 14)
        XCTAssertEqual(14, interactor!.getFetchedTimes(), "INTERACTOR: Saved and Read immediately")

        interactor!.requestUUID()
            .asDriver(onErrorJustReturn: Result.failure(ErrorWorker.ApiError.unknown))
            .drive(onNext: { result in
                switch result {
                case .success(let response):
                    XCTAssertEqual(response.path, "40f41366-f014-11e9-a404-acbc3289c767")
                    XCTAssertEqual(response.responseCode, "3fc232b5-ae3b-4e8c-891e-0f349d14ae34")
                case .failure(let error):
                    XCTFail(self.errorWorker.process(error: error))
                }
            }).disposed(by: disposeBag)
    }

    func testMainPresenter() {
        XCTAssertNotNil(presenter)

        presenter!.requestNewUUID().drive(onNext: { uuid in
            XCTAssertEqual(uuid, "3fc232b5-ae3b-4e8c-891e-0f349d14ae34")
        }).disposed(by: disposeBag)
    }

    func testMainViewModel() {
        let emptyViewModel = ViewModel.empty
        XCTAssertNotNil(emptyViewModel)
        XCTAssertEqual(0, emptyViewModel.index)
        XCTAssertEqual("", emptyViewModel.uuid)

        let newViewModel = ViewModel(index: 10, uuid: "3fc232b5-ae3b-4e8c-891e-0f349d14ae34")
        XCTAssertNotNil(newViewModel)
        XCTAssertEqual(10, newViewModel.index)
        XCTAssertEqual("3fc232b5-ae3b-4e8c-891e-0f349d14ae34", newViewModel.uuid)
    }
}
