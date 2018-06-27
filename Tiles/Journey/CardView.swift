//
//  CardView.swift
//  Tiles
//
//  Created by Tenny on 25/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import SpriteKit
import Koloda


let defaultTopOffset: CGFloat = 20
let defaultHorizontalOffset: CGFloat = 10
let defaultHeightRatio: CGFloat = 1.25
let backgroundCardHorizontalMarginMultiplier: CGFloat = 0.25
let backgroundCardScalePercent: CGFloat = 1.5

class CardView: KolodaView {
    @IBOutlet var cardSKView: SKView!
    var namesArray: [String] = ["Tenny", "Tais", "Foca", "Renata", "Gabriela"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.blue
        delayWithSeconds(0.3) {
        if let scene = SKScene(fileNamed: "MyScene") as? MyScene {
            scene.scaleMode = .aspectFill
            scene.labelName = self.namesArray[Int(arc4random_uniform(4))]
            self.cardSKView.presentScene(scene)
            }
        }
    
    }
    
    
    // HERE!
    override func frameForCard(at index: Int) -> CGRect {
        if index == 0 {
            let topOffset: CGFloat = defaultTopOffset
            let xOffset: CGFloat = defaultHorizontalOffset
            let width = (self.frame).width - 2 * defaultHorizontalOffset
            let height = width * defaultHeightRatio
            let yOffset: CGFloat = topOffset
            let frame = CGRect(x: xOffset, y: yOffset, width: width, height: height)

            return frame
        } else if index == 1 {
            let horizontalMargin = -self.bounds.width * backgroundCardHorizontalMarginMultiplier
            let width = self.bounds.width * backgroundCardScalePercent
            let height = width * defaultHeightRatio
            return CGRect(x: horizontalMargin, y: 0, width: width, height: height)
        }
        return CGRect.zero
    }

}

extension UIView {
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}
