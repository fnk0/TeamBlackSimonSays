//
//  TransparentButton.swift
//  TeamBlackSimonSays
//
//  Created by Marcus Gabilheri on 9/12/15.
//  Copyright © 2015 Gabilheri Apps. All rights reserved.
//

import Foundation
import UIKit

class TransparentButton : UIButton {
    
    @IBInspectable var treshold: CGFloat = 1.0 {
        didSet {
            if treshold > 1.0 {
                treshold = 1.0
            }
            if treshold < 0.0 {
                treshold = 0.0
            }
        }
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return self.alphaFromPoint(point) > treshold
    }
}