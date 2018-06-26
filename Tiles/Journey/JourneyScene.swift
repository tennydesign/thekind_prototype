//
//  JourneyScene.swift
//  Tiles
//
//  Created by Tenny on 25/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import SpriteKit

class JourneyScene: SKScene {

    override func didMove(to view: SKView) {
        if let card = self.childNode(withName: "card") as? SKSpriteNode {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanFrom(withSender:)))
            
            
        }
    }
    
    @objc func handlePanFrom(withSender tap: UIPanGestureRecognizer) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
}
