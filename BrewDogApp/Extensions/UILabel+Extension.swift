//
//  UILabel+Extension.swift
//  BrewDogApp
//
//  Created by Pia on 30/11/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit

extension UILabel {
    
    static var BrewDogLabel: UILabel {
        return UILabel(fromString: nil)
    }
    
    convenience init(fromString string: String?) {
        self.init()
        text = string
        textColor = Style.ListTypes.titleColor
        font = UIFont.brandTitleFont(size: Style.FontSize.description)
        textAlignment = .center
        numberOfLines = 3
    }
}
