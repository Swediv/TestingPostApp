//
//  FetchErrors.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 01.07.2021.
//

import Foundation

enum FetchError: Error {
    case noPosts
}
extension FetchError: LocalizedError {
    var errorDescription: String? {
        switch self {
        
        case .noPosts:
            return "No posts uploaded"
        }
    }
}
