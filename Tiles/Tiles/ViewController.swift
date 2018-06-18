//
//  ViewController.swift
//  Tiles
//
//  Created by Tenny on 11/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet weak var boardSkView: SKView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let scene = SKScene(fileNamed: "BoardScene") as? BoardScene {
            scene.scaleMode = .aspectFill
            boardSkView.presentScene(scene)
      
        } else {
            print("scene not found")
        }
        boardSkView.ignoresSiblingOrder = true
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

