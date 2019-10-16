//
//  LocalizedLabel.swift
//  GlobalRadioChallenge
//
//  Created by Adam Bella on 10/16/19.
//  Copyright © 2019 Bella Ádám. All rights reserved.
//

import UIKit

@IBDesignable
class LocalizedLabel: UILabel {

    @IBInspectable var localizationKey: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        text = localizationKey?.localized
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        text = localizationKey
    }

}
