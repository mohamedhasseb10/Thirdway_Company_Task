//
//  ProductDetailsViewModel.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 30/01/2022.
//

import Foundation
/**
 
     The Class was desined and implemented to write business logic of Product Details Screen.
*/
class ProductDetailsViewModel {
    // MARK: - Variables
    var productSelected: ProductItem
    // MARK: - init
    public init (_ product: ProductItem) {
        productSelected = product
    }
}
