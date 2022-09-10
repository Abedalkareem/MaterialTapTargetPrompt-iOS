//
//  CGRect+Helpers.swift
//  MaterialTapTargetPrompt
//
//  Created by abedalkareem omreyh on 09/09/2022.
//

import UIKit

extension CGRect {
  mutating func add(number: CGFloat) {
    self.size.height += number
    self.size.width += number
    self.origin.x -= (number / 2)
    self.origin.y -= (number / 2)
  }
}
