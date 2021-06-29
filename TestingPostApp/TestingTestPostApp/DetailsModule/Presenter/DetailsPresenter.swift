//
//  DetailsPresenter.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation
import UIKit

class DetailsPresenter: DetailsPresenterProtocol {
    
    weak var view: DetailsViewControllerProtocol!
    var interactor: DetailsInteractorProtocol!
    var router: DetailsRouterProtocol!
    
    required init(view: DetailsViewControllerProtocol) {
        self.view = view
    }
    func setAuthorName(with name: String) {
        view.showAuthorName(with: name)
    }
    
    func setAuthorImage(with image: UIImage?) {
        view.showAuthorImage(with: image)
    }
    
    func setContentImage(with image: UIImage?) {
        view.showContentImage(with: image)
    }
    
    func setDescriptionText(with text: [String]) {
        view.showDescriptionText(with: text)
    }
    
    func updateView() {
        interactor.getDescriptionText()
        interactor.getContentImage()
        interactor.getAuthorName()
        interactor.getAuthorImage()
    }  
}
