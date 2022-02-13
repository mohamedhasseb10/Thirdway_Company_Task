//
//  NETWORK+ENDPOINTS.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import Foundation

extension Endpoint {
    static func productList() -> Endpoint {
        let base = Environment.baseURL
        let path = "/b/1P7S"
        return Endpoint(base: base,
                        path: path)
    }
}
