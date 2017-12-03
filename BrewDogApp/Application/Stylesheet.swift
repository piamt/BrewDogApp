//
//  Style.swift
//  BrewDogApp
//
//  Created by Pia on 27/11/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import UIKit

struct Style {
    struct ListTypes {
        static let collectionBGColor: UIColor = UIColor.BrandBG()
        
        static let titleColor: UIColor = UIColor.BrandBlack()
        
        static let collectionCellColor: UIColor = UIColor.BrandCard()
        
        static let title: String = "Beer list"
        
        static let searchPlaceholder: String = "Type food here"
        
        static let orderButton: String = "Order %"
    }
    
    struct FontSize {
        static let title: CGFloat = 20.0
        
        static let description: CGFloat = 16.0
    }
}
