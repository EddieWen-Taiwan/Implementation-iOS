//
//  PageContentViewController.swift
//  Goutham
//
//  Created by Eddie on 2/26/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!

    var bgImgName: String?
    var imageName: String?
    var titleText: String?
    var descText: String?

    var pageIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if let bgImgName = bgImgName {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: bgImgName)!)
        }
        if let imageName = imageName {
            image.image = UIImage(named: imageName)
        }
        if let titleText = titleText {
            titleLabel.text = titleText
        }
        if let descText = descText {
            descLabel.text = descText
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
