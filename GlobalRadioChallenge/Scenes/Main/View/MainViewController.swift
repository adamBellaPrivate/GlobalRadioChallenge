//
//  MainViewController.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/15/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet private weak var lblUUID: UILabel!
    @IBOutlet private weak var lblCountFetchedTimes: UILabel!
    @IBOutlet private weak var btnGenerate: UIButton!

    private var disposeBag = DisposeBag()
    private let fetchedTimes = BehaviorRelay<Int>(value: 0)
    private let isEnabledActionButton = BehaviorRelay<Bool>(value: false)
    private lazy var presenter: MainPresenterProtocol = MainPresenter(self, interactor: MainInteractor(apiWorker: ApiWorker(), userDefaultsWorker: UserDefaultsWorker()))

    override func viewDidLoad() {
        super.viewDidLoad()

        performInitialScene()
        subscriptionToRx()
        presenter.onViewLoaded()
    }

    deinit {
        disposeBag = DisposeBag()
    }

}

extension MainViewController: MainDisplayLogic {

   final func onShowFetchedTime(count: Int) {
        fetchedTimes.accept(count)
   }

}

private extension MainViewController {

    final func performInitialScene() {
        lblUUID.text = "--"
    }

    final func subscriptionToRx() {
        isEnabledActionButton.distinctUntilChanged()
            .bind(to: btnGenerate.rx.isEnabled)
            .disposed(by: disposeBag)

        isEnabledActionButton.asDriver()
            .skip(1)
            .distinctUntilChanged()
            .drive(onNext: { [weak self] isEnabled in
                guard isEnabled else { return }
                self?.subscriptionToContentButton()
        }).disposed(by: disposeBag)

        fetchedTimes.asDriver()
            .drive(onNext: { [weak self] count in
            self?.lblCountFetchedTimes.text = "\(count)"
        }).disposed(by: disposeBag)

        fetchedTimes.asDriver()
            .skip(1)
            .drive(onNext: { [weak self] count in
            self?.isEnabledActionButton.accept(true)
            self?.presenter.saveFetchedTimes(count: count)
        }).disposed(by: disposeBag)
    }

    final func subscriptionToContentButton() {
        btnGenerate.rx.tap
               .flatMapLatest({ self.presenter.requestNewUUID() })
               .scan(ViewModel(index: fetchedTimes.value, uuid: "")) { (lastValue, uuid) in
                   return ViewModel(index: lastValue.index + 1, uuid: uuid)
               }
               .asDriver(onErrorJustReturn: ViewModel.empty)
               .filter({ !$0.uuid.isEmpty })
               .drive(onNext: { [weak self] response in
                    self?.lblUUID.text = response.uuid
                    self?.fetchedTimes.accept(response.index)
               }).disposed(by: disposeBag)
    }

}
