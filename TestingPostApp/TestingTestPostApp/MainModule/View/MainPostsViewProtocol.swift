//
//  MainPostsViewProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation

protocol MainPostsViewProtocol: AnyObject {
    func reloadData()
    func startAnimating()
    func stopAnimating()
    func setTableAtStartPosition()
}
