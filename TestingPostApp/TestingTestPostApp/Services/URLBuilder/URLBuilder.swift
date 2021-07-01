//
//  URLBuilder.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

enum Sorting: String {
    case mostPopular = "mostPopular"
    case mostCommented = "mostCommented"
    case createdAt = "createdAt"
}

enum URLBuilder {
    case forLoading(cursor: String?, sorting: Sorting?)
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        
        switch self {
        case let .forLoading(cursor: cursor, sorting: sorting):
            if let cursor = cursor {
                queryItems.append(URLQueryItem(name: "after", value: cursor))
            }
            
            if let sorting = sorting {
                queryItems.append(URLQueryItem(name: "orderBy", value: sorting.rawValue))
            }
        }
        
        return queryItems
    }
    
    var path: String {
        switch self {
        case .forLoading:
            return "/posts/v1/posts"
        }
    }
    
    func build() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "k8s-stage.apianon.ru"
        components.path = path
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        return components.url
    }
}
