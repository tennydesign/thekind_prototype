//
//  ScrollViewController.swift
//  Tiles
//
//  Created by Tenny on 20/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import SpriteKit

class ScrollViewController: UIViewController {


    var imageView: UIImageView!
    var boardSkView: SKView = SKView()
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var boardGameWindow: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.frame = boardGameWindow.bounds
        boardSkView.frame = boardGameWindow.bounds
        scrollView.addSubview(boardSkView)

  //      imageView = UIImageView(image: UIImage(named: "image1.png"))

 //       scrollView.contentSize = imageView.bounds.size
        
        if let scene = SKScene(fileNamed: "TestScrollScene") as? TestScrollScene {
            scene.scaleMode = .aspectFill
            boardSkView.presentScene(scene)
            scrollView.contentSize = scene.frame.size
            scrollView.zoomScale = 0.2
        } else {
            print("scene not found")
        }
        
        boardSkView.ignoresSiblingOrder = true
        
        scrollView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleWidth.rawValue) | UInt8(UIViewAutoresizing.flexibleHeight.rawValue)))
        
        scrollView.isScrollEnabled = true
        
        //scrollView.contentOffset = CGPoint(x: 1000, y: 450)
       // scrollView.addSubview(imageView)


        // Do any additional setup after loading the view.
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
