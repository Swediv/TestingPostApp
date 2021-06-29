//
//  MainPostsRouterTests.swift
//  PostAppTests
//
//  Created by Artem Chuklov on 27.06.2021.
//

import XCTest
@testable import TestingTestPostApp


class MainPostsRouterTests: XCTestCase {

    var view: MainPostsView!
    var viewToPresent: DetailsViewController!
    var router: MainPostsRouter!
    
    override func setUpWithError() throws {
        view = MainPostsView()
        router = MainPostsRouter(view: view)
        viewToPresent = DetailsViewController()
    }

    override func tearDownWithError() throws {
        view = nil
        router = nil
    }
    func testControllerToPresentIsNotNil() {
        let item = Item(id: "test", isCreatedByPage: nil, videoElementID: nil, status: .published, type: .audioCover, coordinates: nil, isCommentable: true, hasAdultContent: false, isAuthorHidden: true, isHiddenInProfile: true, contents: [], language: .ru, awards: .init(recent:[] , statistics: [], voices: 1.4, awardedByMe: true), createdAt: 4, updatedAt: 7, isSecret: false, page: nil, author: nil, stats: .init(likes: .init(count: 2, my: true), views: .init(count: 2, my: true), comments: .init(count: 5, my: false), shares: .init(count: 3, my: false), replies: .init(count: 3, my: true), timeLeftToSpace: .init(count: nil, maxCount: nil, my: true)), isMyFavorite: true)
        router.presentDetailViewController(withPost: item)
        XCTAssertNil(viewToPresent)
        
    }

}
