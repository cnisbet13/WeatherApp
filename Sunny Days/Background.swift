//
//  Background.swift
//  Sunny Days
//
//  Created by Calvin Nisbet on 2015-07-07.
//  Copyright (c) 2015 Calvin Nisbet. All rights reserved.
//

import UIKit

class Background: UIView {

    
    override func drawRect(rect: CGRect) {
    
        //// Color Declarations
        var lightRed: UIColor = UIColor(red: 0.900, green: 0.075, blue: 0.202, alpha: 1.000)
        var darkRed: UIColor = UIColor(red: 0.200, green: 0.036, blue: 0.202, alpha: 1.000)
        
        let context = UIGraphicsGetCurrentContext()
        
        //// Gradient Declarations
        let purpleGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [lightRed.CGColor, darkRed.CGColor], [0, 1])
        
        //// Background Drawing
        let backgroundPath = UIBezierPath(rect: CGRectMake(0, 0, self.frame.width, self.frame.height))
        CGContextSaveGState(context)
        backgroundPath.addClip()
        CGContextDrawLinearGradient(context, purpleGradient,
            CGPointMake(160, 0),
            CGPointMake(160, 568),
            UInt32(kCGGradientDrawsBeforeStartLocation) | UInt32(kCGGradientDrawsAfterEndLocation))
        CGContextRestoreGState(context)
    }
}
