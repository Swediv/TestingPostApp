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
    
    var sorting: Sorting? {
        didSet {
            view.stopAnimating()
            interactor.cursor = nil
            interactor.getPosts(sortingBy: sorting, isNeedToClear: true)
            if !posts.isEmpty {
                view.setTableAtStartPosition()
            }
        }
    }
    
    var interactor: MainPostsInteractorProtocol! {
        didSet {
            view.startAnimating()
            interactor.getPosts(sortingBy: sorting, isNeedToClear: true)
        }
    }
    
    var posts = [Item]() {
        didSet {
            self.view.reloadData()
        }
    }
    
    init(view: MainPostsViewProtocol) {
        self.view = view
    }
    
    func loadPosts() {
        view.startAnimating()
        
        interactor.getPosts(sortingBy: sorting, isNeedToClear: true)
    }
    
    func didTapSelectedRow(atPost post: Item) {
        router.presentDetailViewController(withPost: post)
    }
    
    func interactorDidFetchedPosts(with result: Result<[Item], FetchError>, isNeedToClear: Bool) {
        
        if isNeedToClear {
            posts.removeAll()
        }
        switch result {
        case .success(let posts):
            self.posts.append(contentsOf: posts)
            
        case .failure(let error):
            print("Error:", error.localizedDescription)
        }
        
        view.stopAnimating()
    }
}
