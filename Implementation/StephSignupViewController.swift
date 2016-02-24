//
//  ViewController.swift
//  Implementation
//
//  Created by Eddie on 2/24/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class StephSignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self

        let gradient = makeGradientLayer()
            gradient.frame = view.frame

        view.layer.insertSublayer(gradient, atIndex: 0)
    }

    private func makeGradientLayer() -> CAGradientLayer {
        let topColor = UIColor(red: 239/256, green: 117/256, blue: 117/256, alpha: 1).CGColor
        let bottomColor = UIColor(red: 72/256, green: 47/256, blue: 93/256, alpha: 1).CGColor

        let layer = CAGradientLayer()
            layer.colors = [topColor, bottomColor]
            layer.locations = [0.0, 1.0]

        return layer
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing( true )
        return false
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

