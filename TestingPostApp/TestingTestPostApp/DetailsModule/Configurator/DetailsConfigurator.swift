//
//  DetailsConfigurator.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

class DetailsConfigurator: DetailsConfiguratorProtocol {
    
    func configure(with viewController: DetailsViewController, post: Item) {
        let presenter = DetailsPresenter(view: viewController)
        let interactor = DetailsInteractor(presenter: presenter)
        let router = DetailsRouter(view: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.post = post
        
    }
}
