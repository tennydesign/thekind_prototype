//
//  kindBoardTileMap.swift
//  Tiles
//
//  Created by Tenny on 21/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import Foundation
import SpriteKit

class kindBoardMechanics {

    static let sharedInstance = kindBoardMechanics()
    init(){}
    let kindBoardName = "kindBoardTileMap"
    let cameraName = "camera" 
    
    enum tilePaths {
        static var groups:[String:String]  = ["lover": "lover group",
                                            "rebel": "rebel group"]
        static var rules:[String:String] = ["lover":"lover rule",
                                        "rebel":"rebel rule"]
    }
}


