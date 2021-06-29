//
//  MainPostsViewTest.swift
//  PostAppTests
//
//  Created by Artem Chuklov on 27.06.2021.
//

import XCTest
@testable import TestingTestPostApp


class MainPostsViewTest: XCTestCase {

    var view: MainPostsView!
    var presenter: MockPresenter!
    var isLoading = false
    
    override func setUpWithError() throws {
        super.setUp()
        view = MainPostsView()
        presenter = MockPresenter(view: view)
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        super.tearDown()
    }
    func testObjectsAreNotNilAndCorrect() {
        XCTAssertNotNil(view)
        XCTAssertNotNil(presenter)
        XCTAssertIdentical(presenter.view, view)
    }
}
