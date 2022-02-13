//
//  EndPoint.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import Foundation

struct Endpoint {
    let base: String
    let path: String
}
extension Endpoint {
    var url: URL? {
        return URL(string: base + path)
    }
}
