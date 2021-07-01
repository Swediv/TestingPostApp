//
//  MainPostsInteractor.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation

class MainPostsInteractor: MainPostsInteractorProtocol {
    weak var presenter: MainPostsPresenterProtocol!
    
    var cursor: String?
    
    private var isLoading: Bool = false
    
    private var currentRequest: URLSessionDataTask?
    
    init(presenter: MainPostsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getPosts(sortingBy: Sorting?, isNeedToClear: Bool) {
        guard !isLoading else { return }
        
        isLoading = true
        
        currentRequest?.cancel()
        currentRequest = NetworkManager.shared.request(.forLoading(cursor: self.cursor, sorting: sortingBy)) { [weak self] result in
            self?.isLoading = false
            
            switch result {
            case .success(let data):
                let jsonData = ParsingService.shared.decode(Post.self, fromData: data)
                switch jsonData {
                case let .success(post):
                    self?.presenter?.interactorDidFetchedPosts(with: .success(post.data.items), isNeedToClear: isNeedToClear)
                    
                case .failure(.decodeError):
                    self?.presenter.interactorDidFetchedPosts(with: .failure(.noPosts), isNeedToClear: isNeedToClear)
                case .failure(.notData):
                    self?.presenter.interactorDidFetchedPosts(with: .failure(.noPosts), isNeedToClear: isNeedToClear)
                }
            case .failure(_):
                self?.presenter.interactorDidFetchedPosts(with: .failure(.noPosts), isNeedToClear: isNeedToClear)
            }
        }
    }
}
