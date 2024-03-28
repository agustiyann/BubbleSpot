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

public class BubbleSpot: UIView {
    
    // MARK: - Private properties
    
    private let text: String
    private let arrowPosition: ArrowPosition
    private weak var targetView: UIView?
    
    // MARK: - Public properties
    
    // BubbleSpot label
    public var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public var textColor: UIColor = .white {
        didSet {
            label.textColor = textColor
        }
    }
    
    public var arrowColor: CGColor = UIColor.black.cgColor
    
    public var didBubbleTapped: (() -> Void)? = nil
    
    public init(targetView: UIView, text: String, arrowPosition: ArrowPosition) {
        self.text = text
        self.arrowPosition = arrowPosition
        self.targetView = targetView
        
        super.init(frame: .zero)
        
        // Default tooltip appearance
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 5
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func show() {
        guard let targetView = targetView, let superview = targetView.superview else {
            return
        }
        
        // Add label to display tooltip text
        label.text = text
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints for label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        // Add the tooltip view to the superview
        superview.addSubview(self)
        
        // Make tooltip view interactive
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
        
        // Setup constraints for self
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        superview.layoutIfNeeded()
        
        // Add arrow pointer
        addArrowLayer()
    }
    
    public func dismiss() {
        removeFromSuperview()
    }
    
    // MARK: - Private methods
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        self.didBubbleTapped?()
    }
    
    private func addArrowLayer() {
        // Remove existing arrow layers
        layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        
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
        arrowLayer.fillColor = arrowColor
        layer.addSublayer(arrowLayer)
    }
    
    private func setupConstraints() {
        guard let targetView = targetView, let superview = targetView.superview else {
            return
        }
        
        switch arrowPosition {
        case .top:
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -10),
                centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
                leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -8)
            ])
        case .bottom:
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 10),
                centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
                leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -8)
            ])
        case .left:
            NSLayoutConstraint.activate([
                trailingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: -10),
                centerYAnchor.constraint(equalTo: targetView.centerYAnchor),
                leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8)
            ])
        case .right:
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: targetView.trailingAnchor, constant: 10),
                centerYAnchor.constraint(equalTo: targetView.centerYAnchor),
                trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -8)
            ])
        }
    }
}
