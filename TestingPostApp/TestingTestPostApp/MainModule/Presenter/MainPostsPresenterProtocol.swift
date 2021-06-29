//
//  MainPostsPresenterProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation

protocol MainPostsPresenterProtocol: AnyObject {
    var isSorted: Bool { get set }
    var sorting: Sorting? { get set }
    var posts: [Item] { get set }
    init(view: MainPostsViewProtocol)
    func didTapSelectedRow(atPost post: Item)
    func interactorDidFetchedPosts(with result: Result<[Item]?,Error>)
    func interactorDidFetchedNewPosts(with result: Result<[Item]?,Error>)
    func interactorNotFetchedNewPosts()
    func loadPosts(isLoading: Bool)
}
