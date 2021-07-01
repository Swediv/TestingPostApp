//
//  DetailsConfigurator.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

class DetailsConfigurator: DetailsConfiguratorProtocol {
    
    func configure(with ViewController: DetailsViewController, post: Item) {
        let presenter = DetailsPresenter(view: ViewController)
        let interactor = DetailsInteractor(presenter: presenter)
        let router = DetailsRouter(view: ViewController)
        
        ViewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.post = post
        
    }
}
