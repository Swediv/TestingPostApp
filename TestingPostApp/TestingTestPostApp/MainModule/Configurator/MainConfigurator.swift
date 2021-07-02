//
//  MainConfigurator.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 21.06.2021.
//

import Foundation
import UIKit

class MainConfigurator: MainConfiguratorProtocol {
    func configure(with viewController: MainPostsView)  {
        let presenter = MainPostsPresenter(view: viewController)
        let interactor = MainPostsInteractor(presenter: presenter)
        let router = MainPostsRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
    }
    
    
}
