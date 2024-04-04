/**
*  BubbleSpot
*  Copyright (c) Agus Tiyan 2024
*  MIT license, see LICENSE file for details
*/

import UIKit

protocol BubbleSpotProtocol {
    var text: String { get }
    var arrowPosition: ArrowPosition { get }
    var targetView: UIView? { get }
    var textColor: UIColor { get set }
    var arrowColor: UIColor { get set }
    var didBubbleTapped: (() -> Void)? { get set }
    
    func show()
    func dismiss()
}

