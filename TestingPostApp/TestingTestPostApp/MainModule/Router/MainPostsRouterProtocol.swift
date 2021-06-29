//
//  MainPostsRouterProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation

protocol MainPostsRouterProtocol: AnyObject {
    func presentDetailViewController(withPost post: Item)
}
