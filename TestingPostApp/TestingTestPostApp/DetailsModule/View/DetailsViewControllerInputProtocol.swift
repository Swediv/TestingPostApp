//
//  DetailsViewControllerProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation
import UIKit

protocol DetailsViewControllerProtocol: AnyObject {
    func showAuthorName(with name: String)
    func showAuthorImage(with image: UIImage?)
    func showContentImage(with image: UIImage?)
    func showDescriptionText(with text: [String])
}
