//
//  APIRouter.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import Foundation
import UIKit

protocol APIRouter {
    func makeRequest<T: Cachable>(withRequest: URLRequest,
                                  decodingType: T.Type,
                                  completion: @escaping JSONTaskCompletionHandler)  where T: Codable
}
extension APIRouter {
    typealias JSONTaskCompletionHandler = (RequestResult<Cachable, RequestError>) -> Void
    
    func makeRequest<T: Cachable>(withRequest: URLRequest,
                                  decodingType: T.Type,
                                  completion: @escaping JSONTaskCompletionHandler)  where T: Codable {
        let session = URLSession.shared
        let task = session.dataTask(with: withRequest) { data,
            response, error in
            if error != nil {
                completion(.failure(.connectionError))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                switch statusCode {
                case 200:
                    guard let data = data else {
                        return
                    }
                    self.decodeJsonResponse(
                        decodingType: decodingType,
                        jsonObject: data,
                        completion: completion)
                    break
                case 401:
                    completion(.failure(.authenticationError))
                case 403:
                    completion(.failure(.authorizationError))
                case 404:
                    completion(.failure(.notFound))
                case 500:
                    completion(.failure(.serverError))
                case 501, 503:
                    completion(.failure(.serverUnavailable))
                default:
                    completion(.failure(.unknownError))
                }
            }
        }
        DispatchQueue.global().async {
            task.resume()
        }
    }
    
    func decodeJsonResponse<T: Cachable>(decodingType: T.Type,
                                         jsonObject: Data,
                                         completion: @escaping JSONTaskCompletionHandler) where T: Codable {
            do {
                var genericModel = try JSONDecoder().decode(decodingType, from: jsonObject)
                genericModel.fileName = String(describing: T.self)
                completion(.success(genericModel))
            } catch {
                completion(.failure(.jsonConversionFailure))
            }
    }
}

func makeRequest(url: URL, parameters: [String: Any]?, header: String?, type: HTTPMethod) -> URLRequest {
    var urlRequest = URLRequest(url: url, timeoutInterval: 10)
    do {
        urlRequest.httpMethod = type.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(header, forHTTPHeaderField: "Authorization")
        if let parameters = parameters {
            urlRequest.httpBody   = try JSONSerialization.data(withJSONObject: parameters)
        }
        return urlRequest
    } catch let error {
        print("Error : \(error.localizedDescription)")
    }
    return urlRequest
}
