//
//  MainPresenterTest.swift
//  PostAppTests
//
//  Created by Artem Chuklov on 25.06.2021.
//

import XCTest
@testable import TestingTestPostApp


class MainPresenterTest: XCTestCase {
    var posts: [Item]?
    var presenter: MainPostsPresenter!
    var view: MockMainPostsView!
    var interactor: MockInteractor!
    var router: MockMainPostsRouter!
    
    override func setUpWithError() throws {
        view = MockMainPostsView()
        presenter = MainPostsPresenter(view: view)
        interactor = MockInteractor()
        router = MockMainPostsRouter()
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        interactor = nil
    }
    func testModuleIsNotNil() {
        XCTAssertNotNil(view)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(interactor)
    }
    func testLoadPostsRequestWithCorrectValueOfLoading() {
        presenter.loadPosts(isLoading: true)
        XCTAssertTrue(interactor.getProcessToLoad)
        XCTAssertEqual(interactor.isLoading, true)
    }
    func testIsSelectedRowCorrect() {
        let item = Item(id: "test", isCreatedByPage: nil, videoElementID: nil, status: .published, type: .audioCover, coordinates: nil, isCommentable: true, hasAdultContent: false, isAuthorHidden: true, isHiddenInProfile: true, contents: [], language: .ru, awards: .init(recent:[] , statistics: [], voices: 1.4, awardedByMe: true), createdAt: 4, updatedAt: 7, isSecret: false, page: nil, author: nil, stats: .init(likes: .init(count: 2, my: true), views: .init(count: 2, my: true), comments: .init(count: 5, my: false), shares: .init(count: 3, my: false), replies: .init(count: 3, my: true), timeLeftToSpace: .init(count: nil, maxCount: nil, my: true)), isMyFavorite: true)
        presenter.didTapSelectedRow(atPost: item)
        XCTAssertEqual(router.post.id, "test")
        XCTAssertEqual(router.post.type, .audioCover)
    }
    func testPresenterSetCorrectValueIfReturnedResultWithSucces() {
        let items = [Item(id: "test", isCreatedByPage: nil, videoElementID: nil, status: .published, type: .audioCover, coordinates: nil, isCommentable: true, hasAdultContent: false, isAuthorHidden: true, isHiddenInProfile: true, contents: [], language: .ru, awards: .init(recent:[] , statistics: [], voices: 1.4, awardedByMe: true), createdAt: 4, updatedAt: 7, isSecret: false, page: nil, author: nil, stats: .init(likes: .init(count: 2, my: true), views: .init(count: 2, my: true), comments: .init(count: 5, my: false), shares: .init(count: 3, my: false), replies: .init(count: 3, my: true), timeLeftToSpace: .init(count: nil, maxCount: nil, my: true)), isMyFavorite: true)]
        presenter.interactorDidFetchedPosts(with: .success(items))
        XCTAssertEqual(presenter.posts.count, 1)
        presenter.interactorDidFetchedNewPosts(with: .success(items))
        XCTAssertEqual(presenter.posts.count, 2)
        
    }
    func testPresenterSetEmptyArrayIfReturnsResultWithSuccesNil() {
        
        presenter.interactorDidFetchedPosts(with: .success(nil))
        XCTAssertEqual(presenter.posts.count, 0)
    }
    func testPresenterGetNilValuesIfReturnsResultWithFailure() {
        let error: Error = NSError(domain: "Error", code: 1, userInfo: [:])
        presenter.interactorDidFetchedPosts(with:.failure(error))
        XCTAssertNil(self.posts)
        presenter.interactorDidFetchedNewPosts(with: .failure(error))
        XCTAssertNil(self.posts)
    }
    func testPresenterGetNotResultAndStopAnimation() {
        presenter.interactorNotFetchedNewPosts()
        XCTAssertEqual(view.animating, .stoping)
        XCTAssertFalse(view.isLoading)
    }
    func testValueOfSortingDidChange() {
        presenter.posts = [Item(id: "test", isCreatedByPage: nil, videoElementID: nil, status: .published, type: .audioCover, coordinates: nil, isCommentable: true, hasAdultContent: false, isAuthorHidden: true, isHiddenInProfile: true, contents: [], language: .ru, awards: .init(recent:[] , statistics: [], voices: 1.4, awardedByMe: true), createdAt: 4, updatedAt: 7, isSecret: false, page: nil, author: nil, stats: .init(likes: .init(count: 2, my: true), views: .init(count: 2, my: true), comments: .init(count: 5, my: false), shares: .init(count: 3, my: false), replies: .init(count: 3, my: true), timeLeftToSpace: .init(count: nil, maxCount: nil, my: true)), isMyFavorite: true)]
        presenter.sorting = .mostPopular
        XCTAssertEqual(view.animating, .starting)
        XCTAssertNil(interactor.cursor)
        XCTAssertTrue(view.settingTableAtStart)
    }
}
