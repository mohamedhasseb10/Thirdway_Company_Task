//
//  BaseRepository.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import Foundation

protocol Repository {
    var networkClient: APIRouter { get }
    var cacher: Cacher { get }

    func getData<T: Cachable>(withRequest: URLRequest,
                              name: String,
                              decodingType: T.Type,
                              strategy: Strategy,
                              completion: @escaping RepositoryCompletion)
        where T: Codable
}
extension Repository {
    typealias RepositoryCompletion = (RequestResult<Cachable, RequestError>) -> Void
    func getData<T: Cachable>(withRequest: URLRequest,
                              name: String,
                              decodingType: T.Type,
                              strategy: Strategy,
                              completion: @escaping RepositoryCompletion)
        where T: Codable {
            networkClient.makeRequest(withRequest: withRequest, decodingType: decodingType) { (result) in
                switch result {
                case .success(let data):
                    if strategy == .defaultStrategy {
                        self.cacher.persist(item: data!) { (_, _) in
                    }
                  }
                case .failure(.connectionError):
                    if strategy == .defaultStrategy {
                        let cached: T? = self.cacher.load(fileName: name)
                        completion(.success(cached))
                        return
                    }
                default :
                    break
                }
                completion(result)
            }
    }
}
