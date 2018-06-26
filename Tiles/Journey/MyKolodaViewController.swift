//
//  JourneyViewController.swift
//  Tiles
//
//  Created by Tenny on 25/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import Koloda
import Foundation

class JourneyViewController: UIViewController {
    var images: [UIImage] = [#imageLiteral(resourceName: "bear"),#imageLiteral(resourceName: "buffalo"),#imageLiteral(resourceName: "chick"),#imageLiteral(resourceName: "duck")]
    @IBOutlet weak var kolodaView: KolodaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        kolodaView.dataSource = self
        kolodaView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension JourneyViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
 
    }
    
}

extension JourneyViewController: KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let customView = Bundle.main.loadNibNamed("View", owner: nil, options: nil)?.first as? CardView
        return customView! //UIImageView(image: images[index])
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return images.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
    }

}
