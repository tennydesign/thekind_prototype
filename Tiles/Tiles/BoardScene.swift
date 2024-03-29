//
//  BoardScene.swift
//  Tiles
//
//  Created by Tennyson Pinheiro on 6/13/18.
//  Copyright © 2018 imat. All rights reserved.
//
// HAD TO 0.5 / 0.5 the scene center in order for location to work.

import UIKit
import SpriteKit

class BoardScene: SKScene {

    var lastCamScale: CGFloat = 0.34
    let initCamScale: CGFloat = 0.34
    let maxZoomLimit: CGFloat = 0.60

    override func didMove(to view: SKView) {
        
        if let camera = scene?.childNode(withName: kindBoardMechanics.sharedInstance.cameraName) as? SKCameraNode {
           // camera.position = (player?.position)!
            camera.setScale(initCamScale)
            self.camera = camera
        }
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanFrom(withSender:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapFrom(withSender:)))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchFrom(withSender:)))
        
        self.view?.addGestureRecognizer(panGestureRecognizer)
        self.view?.addGestureRecognizer(tapGestureRecognizer)
        self.view?.addGestureRecognizer(pinchGestureRecognizer)
        

    }
    

    //This alows the user to tap the tile.
    @objc func handleTapFrom(withSender tap: UITapGestureRecognizer) {
        if tap.state != .ended {
            return
        }

        
        if let tilemap = scene?.childNode(withName: kindBoardMechanics.sharedInstance.kindBoardName ) as? SKTileMapNode {

            //natural tapped Location: viewPoint
            //converted Location: scenePoint
            // IMPORTANT: For the conversion to work it is important that the scene is centered at 0,5 / 0.5
            let viewPoint = tap.location(in: tap.view)
            let scenePoint = self.convertPoint(fromView: viewPoint)
            
            if tilemap.contains(scenePoint) {
                //print("found tile in location")
                let col = tilemap.tileColumnIndex(fromPosition: scenePoint)
                let row = tilemap.tileRowIndex(fromPosition: scenePoint)
 
                let centerOfTile = tilemap.centerOfTile(atColumn: col, row: row)
                // HOW TO CHANGE THE TILE WHEN CLICKED
                let lover: Lover = Lover(kindType: .wired)
                let rebel: Rebel = Rebel(kindType: .social)
                
 //               lover.kindType = .wired
                
                replaceTileAt(row: row, col: col, kind: lover)
                
                if let magic = SKEmitterNode(fileNamed: "Portal.sks") {
                    
                    magic.position = centerOfTile
                    magic.name = "magic"
                    tilemap.addChild(magic)
                    let wait: SKAction = SKAction.wait(forDuration: 0.5)
                    let fadeIn: SKAction = SKAction.fadeIn(withDuration: 0.2)
                    let animationDuration: SKAction = SKAction.wait(forDuration: 2)
                    let fadeOut: SKAction = SKAction.fadeOut(withDuration: 1)
                    //let remove: SKAction = SKAction.removeFromParent()
                    let seq: SKAction = SKAction.sequence([wait,fadeIn,animationDuration,fadeOut])
                    magic.run(seq)
                }
                
                // HOW TO READ WHICH TILE WAS CLICKED
                print("Value is: \(retrieveTileDataWithKeyAt(row: row, col: col, forKey: "kind"))")
                //let value = retrieveTileDataWithKeyAt(row: row, col: col, forKey: "kind")
            }
        }
    }



    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }


    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
}

