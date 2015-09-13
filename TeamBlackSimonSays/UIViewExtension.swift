//
//  UIViewExtension.swift
//  TeamBlackSimonSays
//
//  Created by Marcus Gabilheri on 9/12/15.
//  Copyright © 2015 Gabilheri Apps. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func alphaFromPoint(point: CGPoint) -> CGFloat {
        var pixel: [UInt8] = [0, 0, 0, 0]
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        let alphaInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
        let context = CGBitmapContextCreate(&pixel, 1, 1, 8, 4, colorSpace, alphaInfo.rawValue)
        
        CGContextTranslateCTM(context, -point.x, -point.y);
        
        self.layer.renderInContext(context!)
        
        let floatAlpha = CGFloat(pixel[3])
        return floatAlpha
    }
}
