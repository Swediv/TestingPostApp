//
//  DecodeErrors.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 24.06.2021.
//

import Foundation

enum DecodeError: Error {
    case decodeError
    case notData
}
extension DecodeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodeError:
            return "Failed to decode JSON"
        case .notData:
            return "Not get data"
        }
    }
}
