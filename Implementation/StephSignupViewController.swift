//
//  ViewController.swift
//  Implementation
//
//  Created by Eddie on 2/24/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class StephSignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var scrollViewBottomConstraint: NSLayoutConstraint!

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var mailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        mailTextField.delegate = self
        passwordTextField.delegate = self

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        let gradient = makeGradientLayer()
            gradient.frame = view.frame

        scrollView.layer.insertSublayer(gradient, atIndex: 0)
    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            scrollViewBottomConstraint.constant = keyboardSize.height - 70
        }
    }

    func keyboardWillHide(notification: NSNotification) {
        scrollViewBottomConstraint.constant = 0
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

