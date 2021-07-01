//
//  MainPostsRouter.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation
import UIKit

class MainPostsRouter: MainPostsRouterProtocol {

    weak var view: MainPostsView!
    
    init(view: MainPostsView) {
        self.view = view
    }
    func presentDetailViewController(withPost post: Item) {
        let vc = DetailsViewController()
        vc.configurator.configure(with: vc, post: post)
        view.navigationController?.pushViewController(vc, animated: true)
    }
    
}
