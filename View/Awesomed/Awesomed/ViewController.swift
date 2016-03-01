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
    @IBOutlet var writeBtn: UIButton!
    @IBOutlet var loveBtn: UIButton!

    @IBOutlet var activeLight: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Add gradient layer
        let mask = makeMaskLayer()
            mask.frame = CGRectMake(0, 0, maskView.frame.width, maskView.frame.height)
        maskView.layer.insertSublayer(mask, atIndex: 0)

        let btnBg = makeButtonGradient()
            btnBg.frame = CGRectMake(0, 0, writeBtn.frame.width, writeBtn.frame.height)
            btnBg.cornerRadius = 25
        writeBtn.layer.addSublayer(btnBg)
        writeBtn.layer.cornerRadius = 25
        loveBtn.layer.cornerRadius = 25
        loveBtn.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7).CGColor
        loveBtn.layer.borderWidth = 1

        activeLight.backgroundColor = UIColor.clearColor()
        activeLight.layer.cornerRadius = 3
        activeLight.layer.borderWidth = 1
        activeLight.layer.borderColor = UIColor(red: 155/255, green: 1, blue: 150/255, alpha: 1).CGColor
    }

    private func makeButtonGradient() -> CAGradientLayer {
        let gradient = CAGradientLayer()
            gradient.colors = [
                UIColor(red: 246/255, green: 161/255, blue: 139/255, alpha: 1).CGColor,
                UIColor(red: 219/255, green: 135/255, blue: 177/255, alpha: 1).CGColor
            ]
            gradient.locations = [0, 1]
            gradient.startPoint = CGPoint(x: 0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1, y: 0.5)

        return gradient
    }

    private func makeMaskLayer() -> CAGradientLayer {
        let maskLayer = CAGradientLayer()
            maskLayer.colors = [UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
            maskLayer.locations = [0, 1]

        return maskLayer
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

