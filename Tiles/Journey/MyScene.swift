//
//  MyScene.swift
//  Tiles
//
//  Created by Tenny on 25/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import SpriteKit

class MyScene: SKScene {
    var labelName: String = "Tenny"
    override func didMove(to view: SKView) {
        if let label = self.childNode(withName: "label") as? SKLabelNode {
            label.text = labelName
        }
        
        if let magic = SKEmitterNode(fileNamed: "Magic.sks") {
            
            magic.position = CGPoint(x: 100, y: 100)
            magic.name = "magic"
            self.addChild(magic)
            let wait: SKAction = SKAction.wait(forDuration: 0.5)
            let fadeIn: SKAction = SKAction.fadeIn(withDuration: 0.5)
            //let animationDuration: SKAction = SKAction.wait(forDuration: 2)
            //let fadeOut: SKAction = SKAction.fadeOut(withDuration: 1)
            //let remove: SKAction = SKAction.removeFromParent()
            let seq: SKAction = SKAction.sequence([wait,fadeIn])
            magic.run(seq)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let label = self.childNode(withName: "label") as? SKLabelNode {
            label.text = labelName
        }
    }
}
