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

    var lastCamScale: CGFloat = 0.18
    
    override func didMove(to view: SKView) {
        
        if let camera = scene?.childNode(withName: "camera") as? SKCameraNode {
           // camera.position = (player?.position)!
            self.camera = camera
        }
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanFrom(withSender:)))
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapFrom(withSender:)))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchFrom(withSender:)))
        
        self.view?.addGestureRecognizer(panGestureRecognizer)
        self.view?.addGestureRecognizer(tapGestureRecognizer)
        self.view?.addGestureRecognizer(pinchGestureRecognizer)
        
        
        
    }
    
    // SLIDES BUT DOESNT TAP
    @objc func handlePanFrom(withSender sender: UIPanGestureRecognizer) {
        var targetPosition: CGPoint!
        
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: sender.view)
            let changeX = (camera?.position.x)! - translation.x*20
            let changeY = (camera?.position.y)! + translation.y*20
            targetPosition = CGPoint(x: changeX, y: changeY)
            
            //self.camera?.position = targetPosition
            //self.view?.center = CGPoint(x: changeX, y: changeY)
            let action: SKAction = SKAction.move(to: targetPosition, duration: 1)
            
            //action.timingMode = .easeOut

            action.timingFunction = CubicEaseOut
            
            self.camera?.run(action)
            
            sender.setTranslation(CGPoint.zero, in: sender.view)
            
    
        }
        
    }
    
    //TAP WHEN NOT SLIDING
    @objc func handleTapFrom(withSender tap: UITapGestureRecognizer) {
        if tap.state != .ended {
            return
        }
        
        if let tilemap = scene?.childNode(withName: "tileMapNode") as? SKTileMapNode {

            let viewPoint = tap.location(in: tap.view)
            
            let scenePoint = self.convertPoint(fromView: viewPoint)
            print("natural tapped Location: \(viewPoint)")
            print("converted Location: \(scenePoint)")
            
            if tilemap.contains(scenePoint) {
                print("found")
                let col = tilemap.tileColumnIndex(fromPosition: scenePoint)
                let row = tilemap.tileRowIndex(fromPosition: scenePoint)
                let tile = tilemap.tileDefinition(atColumn: col, row: row)
                print(" \(String(describing: tile?.name)) - col \(col) - row\(row)")
               
                tilemap.setTileGroup(nil, forColumn: col, row: row)
            }
            

        }
        
    }
    
    // ZOOMING IN AND OUT
    @objc func handlePinchFrom(withSender pinch: UIPinchGestureRecognizer) {

        
        if pinch.state == .began {
            lastCamScale = (camera?.xScale)!
        }
        camera?.setScale(lastCamScale * 1 / pinch.scale)
        
    }
    
    
    
    func CubicEaseOut(_ t:Float)->Float
    {
        let f:Float = (t - 1);
        return f * f * f + 1;
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
