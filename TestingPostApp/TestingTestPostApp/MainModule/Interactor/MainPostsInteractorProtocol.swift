//
//  MainPostsInteractorProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation

protocol MainPostsInteractorProtocol: AnyObject {
    var cursor: String? { get set }
    init(presenter: MainPostsPresenterProtocol)
    func getPosts(withSorting isSorted: Bool, sortingBy: Sorting?, isLoading: Bool)
}
