//
//  Environment.swift
//  ThirdwayTask
//
//  Created by Mohamed Hasseb on 27/01/2022.
//

import Foundation

public enum Environment {
    // MARK: - Keys
        enum PlistKeys {
            static let baseURL = "BASE_URL"
        }
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    // MARK: - Plist values
    static let baseURL: String = {
        guard let baseURLstring = Environment.infoDictionary[PlistKeys.baseURL] as? String else {
            fatalError("base URL not set in plist for this environment")
        }
        guard let url = URL(string: baseURLstring) else {
            fatalError("Base URL is invalid")
        }
        return baseURLstring
    }()
}
