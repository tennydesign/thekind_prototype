//
//  JourneyViewController.swift
//  Tiles
//
//  Created by Tenny on 25/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import SpriteKit

class JourneyViewController: UIViewController {

    @IBOutlet var journeySkView: SKView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let scene = SKScene(fileNamed: "JourneyScene") as? JourneyScene {
            scene.scaleMode = .aspectFill
            journeySkView.presentScene(scene)
        } else {
            print("scene not found")
        }
        journeySkView.ignoresSiblingOrder = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
