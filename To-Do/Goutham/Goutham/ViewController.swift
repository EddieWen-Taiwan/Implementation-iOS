//
//  ViewController.swift
//  Goutham
//
//  Created by Eddie on 3/7/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var newTaskButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newTaskButton.layer.cornerRadius = 30
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

