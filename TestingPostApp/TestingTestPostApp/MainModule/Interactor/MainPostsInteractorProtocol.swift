//
//  MainPostsInteractorProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation

protocol MainPostsInteractorProtocol: AnyObject {
    var cursor: String? { get set }
    func getPosts(sortingBy: Sorting?, isNeedToClear: Bool)
}
