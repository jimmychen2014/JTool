//
//  NSLayoutConstraint+LayoutConstraintActivation.swift
//  JTool
//
//  Created by Jingting Chen on 2019/8/20.
//  Copyright © 2019 Jingting. All rights reserved.
//

import UIKit

public extension Array where Element : NSLayoutConstraint {

  func activate()
  {
    NSLayoutConstraint.activate(self)
  }

  func deactive()
  {
    NSLayoutConstraint.deactivate(self)
  }

}
