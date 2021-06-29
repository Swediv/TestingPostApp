//
//  UIScrollView.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation
import UIKit

extension UIScrollView {
    var isOverflowVertical: Bool {
        return self.contentSize.height > self.frame.height && self.frame.height > 0
    }
    func isReachedBottom(withTolerance tolerance: CGFloat = 0) -> Bool {
        guard self.isOverflowVertical else { return false }
        let contentOffsetBottom = self.contentOffset.y + self.frame.height
        return contentOffsetBottom >= self.contentSize.height - tolerance
    }
    
}
