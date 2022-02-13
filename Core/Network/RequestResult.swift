//
//  RequestResult.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import Foundation

public enum RequestResult<T, U> where U: Error {
    case success(T?)
    case failure(U)
}

enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError
    case authenticationError
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case jsonConversionFailure
}

enum Strategy: String {
    case networkOnly
    case defaultStrategy
}

public enum State {
    case loading
    case error
    case empty
    case populated
}
