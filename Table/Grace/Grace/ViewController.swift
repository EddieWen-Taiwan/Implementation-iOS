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
    @IBOutlet var trophy1: UIImageView!
    @IBOutlet var no1_left_constraint: NSLayoutConstraint!
    @IBOutlet var no_2_View: UIView!
    @IBOutlet var trophy2: UIImageView!
    @IBOutlet var no2_left_constraint: NSLayoutConstraint!
    @IBOutlet var no_3_View: UIView!
    @IBOutlet var trophy3: UIImageView!
    @IBOutlet var no3_left_constraint: NSLayoutConstraint!
    @IBOutlet var no_4_View: UIView!
    @IBOutlet var trophy4: UIImageView!
    @IBOutlet var no4_left_constraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        trophy1.transform = CGAffineTransformMakeScale(0.1, 0.1)
        trophy1.alpha = 0
        trophy2.transform = CGAffineTransformMakeScale(0.1, 0.1)
        trophy2.alpha = 0
        trophy3.transform = CGAffineTransformMakeScale(0.1, 0.1)
        trophy3.alpha = 0
        trophy4.transform = CGAffineTransformMakeScale(0.1, 0.1)
        trophy4.alpha = 0

        no_1_View.roundCorners([.TopRight, .BottomRight], radius: no_1_View.frame.height/2)
        let user1 = User(name: "Coco Bubble Tea", star: 4.7)
        let user1view = UserInfoView(user: user1)
        no_1_View.addSubview(user1view)

        no_2_View.roundCorners([.TopRight, .BottomRight], radius: no_1_View.frame.height/2)
        let user2 = User(name: "Boba Guys", star: 4.1)
        let user2view = UserInfoView(user: user2, maskColor: UIColor(red: 255/255, green: 9/255, blue: 93/255, alpha: 1))
        no_2_View.addSubview(user2view)

        no_3_View.roundCorners([.TopRight, .BottomRight], radius: no_1_View.frame.height/2)
        let user3 = User(name: "Kungfu", star: 3.5)
        let user3view = UserInfoView(user: user3)
        no_3_View.addSubview(user3view)

        no_4_View.roundCorners([.TopRight, .BottomRight], radius: no_1_View.frame.height/2)
        let user4 = User(name: "ViVi", star: 2.9)
        let user4view = UserInfoView(user: user4, maskColor: UIColor(red: 255/255, green: 9/255, blue: 93/255, alpha: 1) )
        no_4_View.addSubview(user4view)

        // Animation
        no1_left_constraint.constant = 0
        UIView.animateWithDuration( 0.3, delay: 0.5, options: .CurveEaseOut, animations: {
            self.no_1_View.layoutIfNeeded()
        }, completion: { finish in
            self.trophy1.alpha = 1
            UIView.animateWithDuration( 0.5, animations: {
                self.trophy1.transform = CGAffineTransformIdentity
            })
        })
        no2_left_constraint.constant = 0
        UIView.animateWithDuration( 0.3, delay: 1, options: .CurveEaseOut, animations: {
            self.no_2_View.layoutIfNeeded()
        }, completion: { finish in
            self.trophy2.alpha = 1
            UIView.animateWithDuration( 0.5, animations: {
                self.trophy2.transform = CGAffineTransformIdentity
            })
        })
        no3_left_constraint.constant = 0
        UIView.animateWithDuration( 0.3, delay: 1.5, options: .CurveEaseOut, animations: {
            self.no_3_View.layoutIfNeeded()
        }, completion: { finish in
            self.trophy3.alpha = 1
            UIView.animateWithDuration( 0.5, animations: {
                self.trophy3.transform = CGAffineTransformIdentity
            })
        })
        no4_left_constraint.constant = 0
        UIView.animateWithDuration( 0.3, delay: 2, options: .CurveEaseOut, animations: {
            self.no_4_View.layoutIfNeeded()
            }, completion: { finish in
                self.trophy4.alpha = 1
                UIView.animateWithDuration( 0.5, animations: {
                    self.trophy4.transform = CGAffineTransformIdentity
                })
        })
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
