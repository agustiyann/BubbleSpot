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
    
    private lazy var bellowBubbleSpot = BubbleSpot(targetView: self.topButton, text: "This is a bubble spot that is below the target view", arrowPosition: .bottom)
    private lazy var rightBubbleSpot = BubbleSpot(targetView: self.leftButton, text: "This is the bubble spot to the right of the target view", arrowPosition: .right)
    private lazy var leftBubbleSpot = BubbleSpot(targetView: self.rightButton, text: "This is the bubble spot to the left of the target view", arrowPosition: .left)
    private lazy var aboveBubbleSpot = BubbleSpot(targetView: self.bottomButton, text: "This is a bubble spot that is above the target view", arrowPosition: .top)
    
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
}

