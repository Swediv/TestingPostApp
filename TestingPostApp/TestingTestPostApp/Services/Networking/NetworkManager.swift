//
//  NetworkManager.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    @discardableResult
    func request(_ builder: URLBuilder, completion: @escaping(Result<Data, Error>) -> Void) -> URLSessionDataTask? {
        guard let url = builder.build() else { return nil }
        
        debugPrint("NetworkManager: request: \(url)")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("NetworkManager: error: \(error)")
                completion(.failure(error))
            }
            if let data = data {
                debugPrint("NetworkManager: success")
                completion(.success(data))
            }
        }
        
        task.resume()
        
        return task
    }
}
