//
//  CardView.swift
//  Tiles
//
//  Created by Tenny on 25/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import SpriteKit
class CardView: UIView {
    @IBOutlet var cardSKView: SKView!
    let namesArray: [String] = ["Tenny", "Tais", "Foca", "Renata", "Gabriela"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        delayWithSeconds(1) {
        if let scene = SKScene(fileNamed: "MyScene") as? MyScene {
            scene.scaleMode = .aspectFill
            scene.labelName = self.namesArray[Int(arc4random_uniform(4))]
            self.cardSKView.presentScene(scene)
            }
        }
    
    }

}

extension UIView {
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}
