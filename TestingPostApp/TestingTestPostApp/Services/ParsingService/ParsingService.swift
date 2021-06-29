//
//  ParsingService.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

protocol ParsingServiceProtocol {
    func decode<R:Decodable>(_ model: R.Type, fromData data: Data?) -> Result<R,DecodeError>
}
class ParsingService: ParsingServiceProtocol {
    
    static let shared = ParsingService()
    
    func decode<R>(_ model: R.Type, fromData data: Data?) -> Result<R, DecodeError> where R : Decodable {
        var result: R
        
        if let data = data {
            do {
                result = try JSONDecoder().decode(R.self, from: data)
                return .success(result)
            } catch  {
                return .failure(.decodeError)
            }
        }
        return .failure(.notData)
    }
}
