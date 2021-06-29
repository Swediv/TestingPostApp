//
//  DetailsRouter.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

class DetailsRouter: DetailsRouterProtocol {
    weak var view: DetailsViewControllerProtocol!
    
    required init(view: DetailsViewControllerProtocol) {
        self.view = view
    }
    
}
