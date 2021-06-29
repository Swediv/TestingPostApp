//
//  NetworkManager.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

protocol NetworkManagerProtocol: AnyObject {
    func request(_ builder: URLBuilder, completion: @escaping(Result<Data, Error>) -> Void)
}
class NetworkManager {
    static let shared = NetworkManager()
    
    func request(_ builder: URLBuilder, completion: @escaping(Result<Data, Error>) -> Void) {
        guard let url = builder.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}
