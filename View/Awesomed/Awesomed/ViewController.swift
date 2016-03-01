//
//  ViewController.swift
//  Awesomed
//
//  Created by Eddie on 2/29/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var maskView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let mask = makeMaskLayer()
            mask.frame = CGRectMake(0, 0, maskView.frame.width, maskView.frame.height)
        maskView.layer.insertSublayer( mask, atIndex: 0 )
    }

    private func makeMaskLayer() -> CAGradientLayer {
        let maskLayer = CAGradientLayer()
            maskLayer.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
            maskLayer.locations = [0.0, 1.0]

        return maskLayer
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

