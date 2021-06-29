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
    
    required init(presenter: MainPostsPresenterProtocol) {
        self.presenter = presenter
    }
    func getPosts(withSorting isSorted: Bool, sortingBy: Sorting?, isLoading: Bool) {
        NetworkManager.shared.request(.forLoading(withCursor: self.cursor, sortingBy: sortingBy, isSorted: isSorted)) { [weak self] result in
            switch result {
            
            case .success(let data):
                let jsonData = ParsingService.shared.decode(Post.self, fromData: data)
                switch jsonData {
                
                case .success(let parseData):
                    if isLoading {
                        guard
                            let newPosts = parseData.data?.items,
                            let cursor = parseData.data?.cursor else {
                            self?.presenter.interactorNotFetchedNewPosts()
                            return
                        }
                        self?.cursor = cursor
                        self?.presenter.interactorDidFetchedNewPosts(with: .success(newPosts))
                    } else {
                        if let posts =  parseData.data?.items {
                            self?.cursor = parseData.data?.cursor
                            self?.presenter.interactorDidFetchedPosts(with: .success(posts))
                        }         
                    }
                case .failure(.decodeError):
                    self?.presenter.interactorDidFetchedPosts(with: .failure(DecodeError.decodeError))
                case .failure(.notData):
                    self?.presenter.interactorDidFetchedPosts(with: .failure(DecodeError.notData))
                }
            case .failure(let error):
                self?.presenter.interactorDidFetchedPosts(with: .failure(error))
                print(error.localizedDescription)
            }
        }
    }
}
