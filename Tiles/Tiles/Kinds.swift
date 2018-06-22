//
//  Kinds.swift
//  Tiles
//
//  Created by Tenny on 21/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import Foundation
import SpriteKit

class Kind:NSObject {
    var tileSet:SKTileSet!
    var group: SKTileGroup!
    var rule: SKTileGroupRule!
    var definition: SKTileDefinition!
    var kindType: KindTypeEnum!
    
    enum KindTypeEnum:String {
        case wired,social
    }
    
    init(kindType: KindTypeEnum) {
        tileSet = SKTileSet(named: "Kinds")!
    }
    

}

//HERE: Refacrtoring and cleaning those exposed strings
class Lover:Kind {
    
    override init(kindType: KindTypeEnum) {
        super.init(kindType: kindType)
        self.kindType = kindType
        self.group = tileSet?.tileGroups.filter({ $0.name == "lover group"}).first
        self.rule = group.rules.filter({ $0.name == "lover rule" }).first
        self.definition = rule.tileDefinitions.filter({$0.name == kindType.rawValue}).first
        
    }
    

}

class Rebel:Kind {
    
    override init(kindType: KindTypeEnum) {
        super.init(kindType: kindType)
        self.kindType = kindType
        self.group = tileSet?.tileGroups.filter({ $0.name == "rebel group"}).first
        self.rule = group.rules.filter({ $0.name == "rebel rule" }).first
        self.definition = rule.tileDefinitions.filter({$0.name == kindType.rawValue}).first
        
    }
    
}
