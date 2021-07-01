//
//  MainPostsPresenterProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation

protocol MainPostsPresenterProtocol: AnyObject {
    var sorting: Sorting? { get set }
    var posts: [Item] { get set }
    func didTapSelectedRow(atPost post: Item)
    func interactorDidFetchedPosts(with result: Result<[Item], FetchError>, isNeedToClear: Bool)
    func loadPosts()
}
