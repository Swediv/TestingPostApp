//
//  DetailsConfiguratorProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation
protocol DetailsConfiguratorProtocol {
    func configure(with ViewController: DetailsViewController, post: Item)
}
