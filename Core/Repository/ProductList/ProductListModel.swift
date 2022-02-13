//
//  ProductListModel.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 28/01/2022.
//

import Foundation

struct ProductListModel: Codable, Cachable {
    var fileName: String? = String(describing: ProductListModel.self)
    var items: [ProductItem]
}

struct ProductItem: Codable {
    var id: Int
    var productDescription: String?
    var image: ProductImage?
    var price: Int?
}

struct ProductImage: Codable {
    var width: Int?
    var height: Int?
    var url: String?
}
