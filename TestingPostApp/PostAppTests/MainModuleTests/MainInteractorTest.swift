//
//  MainInteractorTest.swift
//  PostAppTests
//
//  Created by Artem Chuklov on 27.06.2021.
//

import XCTest
@testable import TestingTestPostApp

class MainInteractorTest: XCTestCase {

    var presenter: MockPresenter!
    var interactor: MainPostsInteractor!
    var manager: MockNetworkManager!
    
    var view: MockMainPostsView!
    
    override func setUpWithError() throws {
        view = MockMainPostsView()
        presenter = MockPresenter(view: view)
        interactor = MainPostsInteractor(presenter: presenter)
        manager = MockNetworkManager()
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        interactor = nil
        manager = nil
    }
    
    func testNetworkManagerReturnedSucces() {
        let expectedResult =
        interactor.getPosts(withSorting: false, sortingBy: nil, isLoading: false)
        
    }
    

}
