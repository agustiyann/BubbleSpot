//
//  BubbleSpot.swift
//  BubbleSpot
//
//  Created by agustiyan on 26/03/24.
//

import Foundation
import UIKit

public enum ArrowPosition {
    case top, bottom, left, right
}

public class TooltipView: UIView {
    
    private let text: String
    private let arrowPosition: ArrowPosition
    private weak var targetView: UIView?
    
    init(targetView: UIView, text: String, arrowPosition: ArrowPosition) {
        self.text = text
        self.arrowPosition = arrowPosition
        self.targetView = targetView
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        guard let targetView = targetView, let superview = targetView.superview else {
            return
        }
        
        // Customize tooltip appearance
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 5
        
        // Add label to display tooltip text
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .center
        addSubview(label)
        
        // Adjust tooltip size based on text content
        let textSize = label.sizeThatFits(CGSize(width: superview.bounds.width - 20, height: CGFloat.greatestFiniteMagnitude))
        let tooltipWidth = min(textSize.width + 20, superview.bounds.width) // Ensure tooltip width accommodates the text
        let tooltipHeight = textSize.height + 10
        frame = CGRect(x: 0, y: 0, width: tooltipWidth, height: tooltipHeight)
        
        // Position label within the tooltip
        label.frame = bounds.insetBy(dx: 10, dy: 5)
        
        // Position tooltip relative to the target view
        var tooltipOrigin: CGPoint = .zero
        
        switch arrowPosition {
        case .top:
            tooltipOrigin = CGPoint(x: targetView.frame.midX - frame.width / 2, y: targetView.frame.minY - frame.height - 10)
        case .bottom:
            tooltipOrigin = CGPoint(x: targetView.frame.midX - frame.width / 2, y: targetView.frame.maxY + 10)
        case .left:
            tooltipOrigin = CGPoint(x: targetView.frame.minX - frame.width - 10, y: targetView.frame.midY - frame.height / 2)
        case .right:
            tooltipOrigin = CGPoint(x: targetView.frame.maxX + 10, y: targetView.frame.midY - frame.height / 2)
        }
        
        frame.origin = tooltipOrigin
        
        // Add arrow pointer
        let arrowLayer = CAShapeLayer()
        let arrowPath = UIBezierPath()
        let arrowWidth: CGFloat = 10
        let arrowHeight: CGFloat = 6
        
        switch arrowPosition {
        case .top:
            arrowPath.move(to: CGPoint(x: bounds.midX - arrowWidth / 2, y: bounds.maxY))
            arrowPath.addLine(to: CGPoint(x: bounds.midX + arrowWidth / 2, y: bounds.maxY))
            arrowPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY + arrowHeight))
            arrowPath.close()
        case .bottom:
            arrowPath.move(to: CGPoint(x: bounds.midX - arrowWidth / 2, y: bounds.minY))
            arrowPath.addLine(to: CGPoint(x: bounds.midX + arrowWidth / 2, y: bounds.minY))
            arrowPath.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY - arrowHeight))
            arrowPath.close()
        case .left:
            arrowPath.move(to: CGPoint(x: bounds.maxX, y: bounds.midY - arrowWidth / 2))
            arrowPath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY + arrowWidth / 2))
            arrowPath.addLine(to: CGPoint(x: bounds.maxX + arrowHeight, y: bounds.midY))
            arrowPath.close()
        case .right:
            arrowPath.move(to: CGPoint(x: bounds.minX, y: bounds.midY - arrowWidth / 2))
            arrowPath.addLine(to: CGPoint(x: bounds.minX, y: bounds.midY + arrowWidth / 2))
            arrowPath.addLine(to: CGPoint(x: bounds.minX - arrowHeight, y: bounds.midY))
            arrowPath.close()
        }
        
        arrowLayer.path = arrowPath.cgPath
        arrowLayer.fillColor = UIColor.black.cgColor
        layer.addSublayer(arrowLayer)
        
        // Add the tooltip view to the superview
        superview.addSubview(self)
        
        // Make tooltip view interactive
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        removeFromSuperview() // Dismiss tooltip when tapped
    }
}
