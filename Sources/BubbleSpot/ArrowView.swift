/**
*  BubbleSpot
*  Copyright (c) Agus Tiyan 2024
*  MIT license, see LICENSE file for details
*/

import UIKit

public enum ArrowDirection {
    case top, bottom, left, right
}

class ArrowView: UIView {
    
    var direction: ArrowDirection = .top
    var fillColor: UIColor = .black
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        
        switch direction {
        case .top:
            context.move(to: CGPoint(x: rect.width / 2, y: 0))
            context.addLine(to: CGPoint(x: rect.width, y: rect.height))
            context.addLine(to: CGPoint(x: 0, y: rect.height))
        case .bottom:
            context.move(to: CGPoint(x: 0, y: 0))
            context.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
            context.addLine(to: CGPoint(x: rect.width, y: 0))
        case .left:
            context.move(to: CGPoint(x: rect.width, y: 0))
            context.addLine(to: CGPoint(x: 0, y: rect.height / 2))
            context.addLine(to: CGPoint(x: rect.width, y: rect.height))
        case .right:
            context.move(to: CGPoint(x: 0, y: 0))
            context.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
            context.addLine(to: CGPoint(x: 0, y: rect.height))
        }
        
        context.closePath()
        
        fillColor.setFill()
        context.drawPath(using: .fillStroke)
    }
}
