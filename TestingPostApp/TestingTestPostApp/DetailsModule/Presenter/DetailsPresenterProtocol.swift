//
//  DetailsPresenterProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation
import UIKit

protocol DetailsPresenterProtocol: AnyObject {
    func updateView()
    func setAuthorName(with name: String)
    func setAuthorImage(with image: UIImage?)
    func setContentImage(with image: UIImage?)
    func setDescriptionText(with text: [String])
}
