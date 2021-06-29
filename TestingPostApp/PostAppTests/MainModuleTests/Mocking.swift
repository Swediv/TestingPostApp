//
//  Mocking.swift
//  PostAppTests
//
//  Created by Artem Chuklov on 27.06.2021.
//

import Foundation
import XCTest
@testable import TestingTestPostApp

class MockInteractor: MainPostsInteractorProtocol {
    
    var cursor: String?
    var isLoading: Bool!
    var isSorted: Bool!
    var sorting: Sorting!
    var getProcessToLoad: Bool!
    var presenter: MainPostsPresenterProtocol!
    
    required init(presenter: MainPostsPresenterProtocol) {
        self.presenter = presenter
    }
    
    
    func getPosts(withSorting isSorted: Bool, sortingBy: Sorting?, isLoading: Bool) {
        self.isLoading = isLoading
        self.getProcessToLoad = true
        self.isSorted = isSorted
        self.sorting = sortingBy
    }
}
class MockMainPostsView: MainPostsViewProtocol {
    enum AnimatingState {
        case starting
        case stoping
    }
    var animating: AnimatingState!
    var isLoading = true
    var settingTableAtStart: Bool!
    
    func reloadData() {
        
    }
    
    func startAnimating() {
        self.animating = .starting
    }
    
    func stopAnimating() {
        self.animating = .stoping
    }
    
    func setTableAtStartPosition() {
        self.settingTableAtStart = true
    }
}
class MockPresenter: MainPostsPresenterProtocol {
    
    var view: MainPostsViewProtocol!
    
    var isSorted = false
    
    var sorting: Sorting?
    
    var posts: [Item] = []
    required init(view: MainPostsViewProtocol) {
        self.view = view
    }
    
    func didTapSelectedRow(atPost post: Item) {
        
    }
    
    func interactorDidFetchedPosts(with result: Result<[Item]?, Error>) {
        
    }
    
    func interactorDidFetchedNewPosts(with result: Result<[Item]?, Error>) {
        
    }
    
    func interactorNotFetchedNewPosts() {
        
    }
    
    func loadPosts(isLoading: Bool) {
        
    }
    
    
}
class MockMainPostsRouter: MainPostsRouterProtocol {
    var post: Item!
    
    func presentDetailViewController(withPost post: Item) {
        self.post = post
    }
    
}
class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
    
}
class MockURLSession: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var error: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        
        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}
class MockItem: ItemProtocol, Codable {
    let itemID: String
    let itemName: String
    
    
    
    init(id: String, name: String, number: Int) {
        itemID = id
        itemName = name
        
    }
}
class MockModel: PostProtocol {
    let items: [MockItem]
    let cursor: String
    
    init(items: [MockItem], cursor: String) {
        self.items = items
        self.cursor = cursor
    }
}
class MockNetworkManager: NetworkManagerProtocol {
    let data = Data(bytes: [0, 1, 0], count: 20)
    func request(_ builder: URLBuilder, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(data))
    }
    
    
}
class MockParsingService: ParsingServiceProtocol {
    func decode<R: Decodable>(_ model: R.Type, fromData data: Data?) -> Result<R, DecodeError> {
        let result = MockItem(id: "1", name: "test", number: 123)
        return .success(result as! R)
    }
    
    
}
