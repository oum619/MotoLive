//
//  UIProgressView+Height.swift
//  MotoLive
//
//  Created by Motomi Ota on 2019/07/05.
//  Copyright © 2019 Motomi Ota. All rights reserved.
//

import UIKit

extension UIProgressView {
  
  @IBInspectable var barHeight : CGFloat {
    get {
      return transform.d * 2.0
    }
    set {
      // 2.0 Refers to the default height of 2
      let heightScale = newValue / 2.0
      let c = center
      transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
      center = c
    }
  }
}
