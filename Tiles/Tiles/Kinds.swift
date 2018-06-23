//
//  Kinds.swift
//  Tiles
//
//  Created by Tenny on 21/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import Foundation
import SpriteKit

fileprivate let kindTileCollectionPath: String = "Kinds"

class Kind:NSObject {
    var tileSet:SKTileSet!
    var group: SKTileGroup!
    var rule: SKTileGroupRule!
    var definition: SKTileDefinition!
    var kindType: KindTypeEnum!
    var groupPath:String!
    var rulePath:String!
    lazy var kindName = String()
    
    enum KindTypeEnum:String {
        case wired,social
    }
    
    init(kindType: KindTypeEnum) {
        super.init()
        tileSet = SKTileSet(named: kindTileCollectionPath)!
        self.kindType = kindType
    }
    
    func loadTileInMap(){
        groupPath = kindBoardMechanics.tilePaths.groups[kindName]!
        rulePath = kindBoardMechanics.tilePaths.rules[kindName]!
        group = tileSet?.tileGroups.filter({$0.name == groupPath}).first
        rule = group.rules.filter({ $0.name == rulePath}).first
        definition = rule.tileDefinitions.filter({$0.name == kindType.rawValue}).first
    }
    

}

class Lover:Kind {

    override init(kindType: KindTypeEnum) {
        super.init(kindType: kindType)
        self.kindName = "lover"
        loadTileInMap()
    }
    

}

class Rebel:Kind {
    
    override init(kindType: KindTypeEnum) {
        super.init(kindType: kindType)
        self.kindName = "rebel"
        loadTileInMap()
    }

    
}
