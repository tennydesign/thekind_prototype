//
//  Kinds.swift
//  Tiles
//
//  Created by Tenny on 21/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import Foundation
import SpriteKit

//HERE
class Kind:NSObject {
    var tileSet:SKTileSet!
    
    override init() {
        tileSet = SKTileSet(named: "Kinds")!
    }
}

class Lover:Kind {
    var group: SKTileGroup!
    var rule: SKTileGroupRule!
    var definition: SKTileDefinition!
    
    override init() {
        super.init()
        self.group = tileSet?.tileGroups.filter({ $0.name == "lover group"}).first
        self.rule = group.rules.filter({ $0.name == "lover rule" }).first
        self.definition = rule.tileDefinitions.filter({$0.name == "Lover Wired"}).first
    }
    
}

class Rebel:Kind {
    var group: SKTileGroup!
    var rule: SKTileGroupRule!
    var definition: SKTileDefinition!
    
    override init() {
        super.init()
        self.group = tileSet?.tileGroups.filter({ $0.name == "rebel group"}).first
        self.rule = group.rules.filter({ $0.name == "rebel rule" }).first
        self.definition = rule.tileDefinitions.filter({$0.name == "Rebel Wired"}).first
    }
    
}
