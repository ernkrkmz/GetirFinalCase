//
//  Basket.swift
//  GetirFinalCase
//
//  Created by Eren Korkmaz on 21.04.2024.
//

import Foundation

struct Basket {
    var verticalProduct : [VerticalProduct]?
    var horizontalProduct : [HorizontalProduct]?
    
    init(verticalProduct: [VerticalProduct]? = [], horizontalProduct: [HorizontalProduct]? = []) {
        self.verticalProduct = verticalProduct
        self.horizontalProduct = horizontalProduct
    }
}
