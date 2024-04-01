//
//  BubbleSpot.swift
//  BubbleSpot
//
//  Created by agustiyan on 26/03/24.
//

import UIKit

public enum ArrowPosition {
    case top
    case bottom
    case left
    case right
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}

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
        
        fillColor.setFill() // Set triangle color
        context.drawPath(using: .fillStroke) // Draw triangle
    }
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // ArrowView
    private let arrowView: ArrowView = {
        let view = ArrowView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(arrowView)
        
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
    }
    
    public func dismiss() {
        removeFromSuperview()
    }
    
    // MARK: - Private methods
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        self.didBubbleTapped?()
    }
    
    private func setupConstraints() {
        guard let targetView = targetView, let superview = targetView.superview else {
            return
        }
        
        switch arrowPosition {
        case .top:
            arrowView.direction = .bottom
            
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -10),
                centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
                leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                arrowView.heightAnchor.constraint(equalToConstant: 6),
                arrowView.widthAnchor.constraint(equalToConstant: 10),
                arrowView.topAnchor.constraint(equalTo: bottomAnchor),
                arrowView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        case .bottom:
            arrowView.direction = .top
            
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 10),
                centerXAnchor.constraint(equalTo: targetView.centerXAnchor),
                leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                arrowView.heightAnchor.constraint(equalToConstant: 6),
                arrowView.widthAnchor.constraint(equalToConstant: 10),
                arrowView.bottomAnchor.constraint(equalTo: topAnchor),
                arrowView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        case .left:
            arrowView.direction = .right
            
            NSLayoutConstraint.activate([
                trailingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: -10),
                centerYAnchor.constraint(equalTo: targetView.centerYAnchor),
                leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                
                arrowView.heightAnchor.constraint(equalToConstant: 10),
                arrowView.widthAnchor.constraint(equalToConstant: 6),
                arrowView.leadingAnchor.constraint(equalTo: trailingAnchor),
                arrowView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        case .right:
            arrowView.direction = .left
            
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: targetView.trailingAnchor, constant: 10),
                centerYAnchor.constraint(equalTo: targetView.centerYAnchor),
                trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                arrowView.heightAnchor.constraint(equalToConstant: 10),
                arrowView.widthAnchor.constraint(equalToConstant: 6),
                arrowView.trailingAnchor.constraint(equalTo: leadingAnchor),
                arrowView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        case .topLeft:
            arrowView.direction = .bottom
            
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -10),
                leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
                trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                arrowView.heightAnchor.constraint(equalToConstant: 6),
                arrowView.widthAnchor.constraint(equalToConstant: 10),
                arrowView.topAnchor.constraint(equalTo: bottomAnchor),
                arrowView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor)
            ])
        case .topRight:
            arrowView.direction = .bottom
            
            NSLayoutConstraint.activate([
                bottomAnchor.constraint(equalTo: targetView.topAnchor, constant: -10),
                leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                trailingAnchor.constraint(equalTo: targetView.trailingAnchor),
                
                arrowView.heightAnchor.constraint(equalToConstant: 6),
                arrowView.widthAnchor.constraint(equalToConstant: 10),
                arrowView.topAnchor.constraint(equalTo: bottomAnchor),
                arrowView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor)
            ])
        case .bottomLeft:
            arrowView.direction = .top
            
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 10),
                leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
                trailingAnchor.constraint(lessThanOrEqualTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -8),
                
                arrowView.heightAnchor.constraint(equalToConstant: 6),
                arrowView.widthAnchor.constraint(equalToConstant: 10),
                arrowView.bottomAnchor.constraint(equalTo: topAnchor),
                arrowView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor)
            ])
        case .bottomRight:
            arrowView.direction = .top
            
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 10),
                leadingAnchor.constraint(greaterThanOrEqualTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 8),
                trailingAnchor.constraint(equalTo: targetView.trailingAnchor),
                
                arrowView.heightAnchor.constraint(equalToConstant: 6),
                arrowView.widthAnchor.constraint(equalToConstant: 10),
                arrowView.bottomAnchor.constraint(equalTo: topAnchor),
                arrowView.centerXAnchor.constraint(equalTo: targetView.centerXAnchor)
            ])
        }
    }
}
