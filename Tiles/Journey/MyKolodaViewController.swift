//
//  JourneyViewController.swift
//  Tiles
//
//  Created by Tenny on 25/06/18.
//  Copyright © 2018 imat. All rights reserved.
//

import UIKit
import Koloda
import pop
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
    
    @IBAction func swipeLeft(_ sender: UIButton) {
        if sender.tag == 1 {
            kolodaView.swipe(.right)
        } else if sender.tag == 0{
            kolodaView.swipe(.left)
        } else if sender.tag == 2 {
            kolodaView.revertAction()
        }
    }
    
}

extension JourneyViewController: KolodaViewDelegate {
    
    // restart cards
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        kolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {

    }
    
    // card behind has a movement.
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    // returns de amount of drag
    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
        print("Card was dragged: \(finishPercentage), to the \(direction.rawValue)")
    }
    
    // after user presses reset.
    func kolodaDidResetCard(_ koloda: KolodaView) {
    
    }
  
    func koloda(_ koloda: KolodaView, didShowCardAt index: Int) {
        print("showing card # \(index)")
    }
    
    //to block a specific card from swiping.
    func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool {
//        if index == 2 {
//            return false
//        }
//        return true
        return true
    }
    
    //returns the % of swipe to be applied to trigget swipe.
    func kolodaSwipeThresholdRatioMargin(_ koloda: KolodaView) -> CGFloat? {
        return 0.7
    }
}

extension JourneyViewController: KolodaViewDataSource {
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        // ============= load card from xib
        let customView = Bundle.main.loadNibNamed("View", owner: nil, options: nil)?.first as? CardView
        
        // ============== input info inside card here
        customView?.namesArray = ["Felipe","Marcelo","João", "Renata", "Tenny"]
        
        return customView!
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return images.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    // Creates an overlay in the card. Look for CustomOverlayView.swift for customization
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
    }

}
