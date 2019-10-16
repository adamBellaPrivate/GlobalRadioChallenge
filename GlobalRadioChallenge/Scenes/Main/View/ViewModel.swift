//
//  ViewModel.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

struct ViewModel {

    let index: Int
    let uuid: String

    static var empty: ViewModel {
        return ViewModel(index: 0, uuid: "")
    }

}
