//
//  MainPostsPresenter.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation

class MainPostsPresenter: MainPostsPresenterProtocol {
    
    weak var view: MainPostsViewProtocol!
    var router: MainPostsRouterProtocol!
    var isSorted = false
    var sorting: Sorting? {
        didSet {
            view.startAnimating()
            interactor.cursor = nil
            interactor.getPosts(withSorting: true, sortingBy: sorting, isLoading: false)
            if !posts.isEmpty {
                view.setTableAtStartPosition()
            }
        }
    }
    var interactor: MainPostsInteractorProtocol! {
        didSet {
            view.startAnimating()
            interactor.getPosts(withSorting: false, sortingBy: nil, isLoading: true)
        }
    }
    var posts = [Item]() {
        didSet {
            self.view.reloadData()
            view.isLoading = false
            print(posts.count)
        }
    }
    
    required init(view: MainPostsViewProtocol) {
        self.view = view
    }
    func loadPosts(isLoading: Bool) {
        view.startAnimating()
        if isSorted {
            interactor.getPosts(withSorting: true, sortingBy: sorting, isLoading: isLoading)
        } else {
            interactor.getPosts(withSorting: false, sortingBy: sorting, isLoading: isLoading)
        }
    }
    func didTapSelectedRow(atPost post: Item) {
        router.presentDetailViewController(withPost: post)
    }
    func interactorDidFetchedPosts(with result: Result<[Item]?, Error>) {
        switch result {
        case .success(let posts):
            if let posts = posts {
                self.posts = posts
            } else {
                self.posts = [Item]()
            }
        case .failure(let error):
            print("Error:", error)
        }
        view.stopAnimating()
        view.isLoading = false
    }
    func interactorDidFetchedNewPosts(with result: Result<[Item]?, Error>) {
        switch result {
        case .success(let newPosts):
            guard let posts = newPosts else { return }
            self.posts.append(contentsOf: posts)
        case .failure(let error):
            print("Error:", error)
        }
        view.stopAnimating()
        view.isLoading = false
    }
    func interactorNotFetchedNewPosts() {
        view.stopAnimating()
        view.isLoading = false
    }
}
