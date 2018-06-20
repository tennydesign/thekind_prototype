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
    let initCamScale: CGFloat = 0.18
    
    override func didMove(to view: SKView) {
        
        if let camera = scene?.childNode(withName: "camera") as? SKCameraNode {
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
    
    // This allows the user to PAN without detecting TAP at the same time.
    @objc func handlePanFrom(withSender sender: UIPanGestureRecognizer) {
    
        var targetPosition: CGPoint!
        
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: sender.view)

            // Current position + translation with a modifier (multiplier) otherwise moves too slow. The modified changes depending on the zoom level of the cam.
            // let changeX = (camera?.position.x)! - translation.x*20 -> the "20" was the modified in the prototype. Now is this monster below.
            // This formula is to make sure the speed of the pan stays the same even if zoomed out //20+20*(1,27-0,18)
            let zoomedSpeedFactor:CGFloat = 10
            let zoomedOutSpeedFactor:CGFloat = 20
            let changeX = (camera?.position.x)! - (translation.x * (zoomedSpeedFactor + zoomedOutSpeedFactor * ((camera?.xScale)! - initCamScale)))
            let changeY = (camera?.position.y)! + (translation.y * (zoomedSpeedFactor + zoomedOutSpeedFactor * ((camera?.xScale)! - initCamScale)))
            targetPosition = CGPoint(x: changeX, y: changeY)
            
            //move to position.
            let action: SKAction = SKAction.move(to: targetPosition, duration: 1)
            
            //action.timingMode = .easeOut
            action.timingFunction = CubicEaseOut
            
            self.camera?.run(action)
            
            //this clears up the gesture buffer? maybe. It doesn't work well without it.
            sender.setTranslation(CGPoint.zero, in: sender.view)
        
    
        }
        
    }
    
    //This alows the user to tap the tile.
    @objc func handleTapFrom(withSender tap: UITapGestureRecognizer) {
        if tap.state != .ended {
            return
        }
        
        if let tilemap = scene?.childNode(withName: "tileMapNode") as? SKTileMapNode {

            //natural tapped Location: viewPoint
            //converted Location: scenePoint
            // For the conversion to work it is important that the scene is centered at 0,5 / 0.5
            let viewPoint = tap.location(in: tap.view)
            let scenePoint = self.convertPoint(fromView: viewPoint)
            
            if tilemap.contains(scenePoint) {
                //print("found tile in location")
                let col = tilemap.tileColumnIndex(fromPosition: scenePoint)
                let row = tilemap.tileRowIndex(fromPosition: scenePoint)
                 //print(" \(String(describing: tile?.name)) - col \(col) - row\(row)")
               
                // manipulate tile here.
                tilemap.setTileGroup(nil, forColumn: col, row: row)
            }
            

        }
        
    }
    
    // Zooming camera
    @objc func handlePinchFrom(withSender pinch: UIPinchGestureRecognizer) {

        if pinch.state == .began {
            //initialize it with the last camera scale state
            lastCamScale = (camera?.xScale)!
        }
        
        // sets the new scale.
        camera?.setScale(lastCamScale * 1 / pinch.scale)
        
        
        // Limits zoom
        
        let zoomOutLimit:CGFloat = 1.0
        let zoomLimit:CGFloat = 0.18
        
        if (camera?.xScale)! < zoomLimit {
            camera?.xScale = zoomLimit
            camera?.yScale = zoomLimit
        }
        
        if (camera?.xScale)! > zoomOutLimit {
            camera?.xScale = zoomOutLimit
            camera?.yScale = zoomOutLimit
        }
        
        
    }
    
    
    // EaseOut function added to action.timingFunction = CubicEaseOut in the Pan gesture handler
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

