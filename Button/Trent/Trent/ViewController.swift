//
//  ViewController.swift
//  Trent
//
//  Created by Eddie on 2/26/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let settingBtn = SettingButton(frame: CGRectMake(self.view.frame.width/2-50, 300, 100, 100))
        self.view.addSubview( settingBtn )
    }

}

