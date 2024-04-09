//
//  ViewController.swift
//  Example
//
//  Created by agustiyan on 26/03/24.
//

import UIKit
import BubbleSpot

class ViewController: UIViewController {

    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var bottomLeftButton: UIButton!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    private lazy var bellowBubbleSpot = BubbleSpot(targetView: self.topButton,
                                                   text: "This is a bubble spot that is bellow the target view",
                                                   bubblePosition: .bottom)
    
    private lazy var rightBubbleSpot = BubbleSpot(targetView: self.leftButton,
                                                  text: "This is the bubble spot to the right of the target view",
                                                  bubblePosition: .right)
    
    private lazy var leftBubbleSpot = BubbleSpot(targetView: self.rightButton,
                                                 text: "This is the bubble spot to the left of the target view",
                                                 bubblePosition: .left)
    
    private lazy var aboveBubbleSpot = BubbleSpot(targetView: self.bottomButton,
                                                  text: "This is a bubble spot that is above the target view",
                                                  bubblePosition: .top)
    
    private lazy var bellowLeftBubbleSpot = BubbleSpot(targetView: self.topLeftButton,
                                                       text: "This is a bubble spot that is bellow [left] the target view",
                                                       bubblePosition: .bottomLeft)
    
    private lazy var bellowRightBubbleSpot = BubbleSpot(targetView: self.topRightButton,
                                                        text: "This is a bubble spot that is bellow [right] the target view",
                                                        bubblePosition: .bottomRight)
    
    private lazy var aboveLeftBubbleSpot = BubbleSpot(targetView: self.bottomLeftButton,
                                                  text: "This is a bubble spot that is above [left] the target view",
                                                  bubblePosition: .topLeft)
    
    private lazy var aboveRightBubbleSpot = BubbleSpot(targetView: self.bottomRightButton,
                                                  text: "This is a bubble spot that is above [right] the target view",
                                                  bubblePosition: .topRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func topButtonPressed(_ sender: UIButton) {
        bellowBubbleSpot.show()
        bellowBubbleSpot.didBubbleTapped = { [weak self] in
            self?.bellowBubbleSpot.dismiss()
        }
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        rightBubbleSpot.show()
        rightBubbleSpot.didBubbleTapped = { [weak self] in
            self?.rightBubbleSpot.dismiss()
        }
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        leftBubbleSpot.show()
        leftBubbleSpot.didBubbleTapped = { [weak self] in
            self?.leftBubbleSpot.dismiss()
        }
    }
    
    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        aboveBubbleSpot.show()
        aboveBubbleSpot.didBubbleTapped = { [weak self] in
            self?.aboveBubbleSpot.dismiss()
        }
    }
    
    @IBAction func topLeftButtonPressed(_ sender: UIButton) {
        bellowLeftBubbleSpot.show()
        bellowLeftBubbleSpot.didBubbleTapped = { [weak self] in
            self?.bellowLeftBubbleSpot.dismiss()
        }
    }
    
    @IBAction func topRightButtonPressed(_ sender: UIButton) {
        bellowRightBubbleSpot.show()
        bellowRightBubbleSpot.didBubbleTapped = { [weak self] in
            self?.bellowRightBubbleSpot.dismiss()
        }
    }
    
    @IBAction func bottomLeftButtonPressed(_ sender: UIButton) {
        aboveLeftBubbleSpot.show()
        aboveLeftBubbleSpot.didBubbleTapped = { [weak self] in
            self?.aboveLeftBubbleSpot.dismiss()
        }
    }
    
    @IBAction func bottomRightButtonPressed(_ sender: UIButton) {
        aboveRightBubbleSpot.show()
        aboveRightBubbleSpot.didBubbleTapped = { [weak self] in
            self?.aboveRightBubbleSpot.dismiss()
        }
    }
}

