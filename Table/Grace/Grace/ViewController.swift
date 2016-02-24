//
//  ViewController.swift
//  Grace
//
//  Created by Eddie on 2/24/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var no_1_View: UIView!
    @IBOutlet var no_2_View: UIView!
    @IBOutlet var no_3_View: UIView!
    @IBOutlet var no_4_View: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        no_1_View.roundCorners([.TopRight, .BottomRight], radius: no_1_View.frame.height/2)
        no_2_View.roundCorners([.TopRight, .BottomRight], radius: no_1_View.frame.height/2)
        no_3_View.roundCorners([.TopRight, .BottomRight], radius: no_1_View.frame.height/2)
        no_4_View.roundCorners([.TopRight, .BottomRight], radius: no_1_View.frame.height/2)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

extension UIView {
    func roundCorners( corners: UIRectCorner, radius: CGFloat ) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
            mask.path = path.CGPath
        self.layer.mask = mask
    }
}
