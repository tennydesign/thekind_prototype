//
//  xt_BoardScene.swift
//  Tiles
//
//  Created by Tenny on 20/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import SpriteKit

extension BoardScene {

 
    // ====================================================
    // MANIPULATING TILE DATA
    //
    //====================================================
    
    func retrieveTileDataWithKeyAt(row: Int, col: Int, forKey: String) -> Any {
        if let tilemap = scene?.childNode(withName: kindBoardMechanics.sharedInstance.kindBoardName) as? SKTileMapNode {
            let tile = tilemap.tileDefinition(atColumn: col, row: row)
            return (tile?.userData?.value(forKey: forKey) ?? "No value found")
        }
        return "No data found"
    }
    
    
    // ====================================================
    // REPLACING TILE WITH OTHER TILE
    //
    //====================================================

    func replaceTileAt(row: Int, col: Int, kind: Kind) {
        
        if let tilemap = scene?.childNode(withName: kindBoardMechanics.sharedInstance.kindBoardName) as? SKTileMapNode {
            // check type of object with a cast.
            if let kind = kind as? Lover {
                print("its a lover")
                tilemap.setTileGroup(kind.group, andTileDefinition: kind.definition, forColumn: col, row: row)
            } else if let kind = kind as? Rebel {
                print("its a rebel")
                tilemap.setTileGroup(kind.group, andTileDefinition: kind.definition, forColumn: col, row: row)
            }
         }
    }
    
    // DEPRECATED
    //
//    func replaceTileAtByName(row: Int, col: Int, set: String, groupName: String, rule: String, definition: String) {
//        if let tilemap = scene?.childNode(withName: kindBoardMechanics.sharedInstance.kindBoardName) as? SKTileMapNode {
//            let tileSet = SKTileSet(named: set)
//            if let tileGroup = tileSet?.tileGroups.filter({ $0.name == groupName}).first {
//                if let tileRule = tileGroup.rules.filter({$0.name == rule}).first {
//                    if  let tileDefinition = tileRule.tileDefinitions.filter({$0.name == definition}).first {
//                        tilemap.setTileGroup(tileGroup, andTileDefinition: tileDefinition, forColumn: col, row: row)
//                    }
//                }
//            }
//        }
//    }
    
    // ====================================================
    // USER GESTURES AND INTERACTIONS WITH THE BOARD
    //
    //====================================================
    
    func returnPanLimit() -> CGFloat {
        // (initCamScale - lastCamScale) * 380 + 420
        //(0,34 - 0,60 )* 380 + 420
        
        return 420
        
    }
    
    func keepWithinPanLimit(for coordinate: inout CGFloat) -> CGFloat
    {
        let limit:CGFloat = returnPanLimit()
        
        if coordinate < -limit || coordinate > limit{
            coordinate = coordinate < 0 ? -limit : limit
        }
        return coordinate
    }
    
    // EaseOut function added to action.timingFunction = CubicEaseOut in the Pan gesture handler
    func CubicEaseOut(_ t:Float)->Float
    {
        let f:Float = (t - 1);
        return f * f * f + 1;
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
        
        let zoomOutLimit:CGFloat = maxZoomLimit
        let zoomLimit:CGFloat = initCamScale
        
        if (camera?.xScale)! < zoomLimit {
            camera?.xScale = zoomLimit
            camera?.yScale = zoomLimit
        }
        
        if (camera?.xScale)! > zoomOutLimit {
            camera?.xScale = zoomOutLimit
            camera?.yScale = zoomOutLimit
        }
        
        print("camera zoom: \(String(describing: camera?.xScale))")
        
    }
    
    // This allows the user to PAN without detecting TAP at the same time.
    @objc func handlePanFrom(withSender sender: UIPanGestureRecognizer) {
        
        var targetPosition: CGPoint!
        
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: sender.view)
            
            // Current position + translation with a modifier (multiplier) otherwise moves too slow. The modified changes depending on the zoom level of the cam.
            // let changeX = (camera?.position.x)! - translation.x*20 -> the "20" was the modified in the prototype. Now is this monster below.
            // This formula is to make sure the speed of the pan stays the same even if zoomed out //20+20*(1,27-0,18)
            let zoomedSpeedFactor:CGFloat = 15
            let zoomedOutSpeedFactor:CGFloat = 25
            var changeX = (camera?.position.x)! - (translation.x * (zoomedSpeedFactor + zoomedOutSpeedFactor * ((camera?.xScale)! - initCamScale)))
            var changeY = (camera?.position.y)! + (translation.y * (zoomedSpeedFactor + zoomedOutSpeedFactor * ((camera?.xScale)! - initCamScale)))
            
            
            print("x:\(changeX) :: y:\(changeY)")
            
            print("coordinate X to go to: \(keepWithinPanLimit(for:&changeX))")
            print("coordinate Y to go to: \(keepWithinPanLimit(for:&changeY))")
            
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
    
}

