//
//  UITableViewCell.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 23.06.2021.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
