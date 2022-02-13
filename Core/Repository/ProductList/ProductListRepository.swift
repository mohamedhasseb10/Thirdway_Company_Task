//
//  ProductListRepository.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 28/01/2022.
//

import Foundation

class ProductListRepository: Repository {
    let cacher: Cacher
    let networkClient: APIRouter
    public init(_ client: APIRouter = NetworkClient()) {
           networkClient = client
           cacher = Cacher(destination: .atFolder("ProductListModel"))
       }
    func getProductList(completion: @escaping RepositoryCompletion) {
        guard let url = Endpoint.productList().url else { return }
        let request = makeRequest(url: url, parameters: nil, header: nil, type: .get)
        getData(withRequest: request,
                name: String(describing: ProductListModel.self),
                decodingType: ProductListModel.self,
                strategy: .defaultStrategy, completion: completion)
    }
}
