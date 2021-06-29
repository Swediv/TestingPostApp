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
struct URLBuilder {
    private var queryItems: [URLQueryItem]?
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "k8s-stage.apianon.ru"
        components.path = "/posts/v1/posts"
        components.queryItems = queryItems
        
        return components.url
    }
    public static func forLoading(withCursor cursor: String?, sortingBy sorting: Sorting?, isSorted: Bool) -> URLBuilder {
        if isSorted {
            if cursor == nil {
                return URLBuilder(queryItems: [URLQueryItem(name: "orderBy", value: sorting?.rawValue)])
            }
            return URLBuilder(queryItems: [URLQueryItem(name: "orderBy", value: sorting?.rawValue), URLQueryItem(name: "after", value: cursor)])
        } else {
            if cursor == nil {
                return URLBuilder(queryItems: nil)
            }
            return URLBuilder(queryItems: [URLQueryItem(name: "after", value: cursor)])
        }
    }
}
