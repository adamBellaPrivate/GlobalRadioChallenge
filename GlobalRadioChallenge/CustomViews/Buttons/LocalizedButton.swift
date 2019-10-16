//
//  LocalizedButton.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

@IBDesignable
class LocalizedButton: UIButton {

    @IBInspectable var localizationKey: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        setTitle(localizationKey?.localized, for: .normal)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setTitle(localizationKey, for: .normal)
    }

}
