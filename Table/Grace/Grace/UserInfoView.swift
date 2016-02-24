//
//  UserInfoView.swift
//  Grace
//
//  Created by Eddie on 2/24/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class UserInfoView: UIView {

    private let thisUser: User
    private let maskColor: UIColor

    init(user: User, maskColor: UIColor) {
        self.thisUser = user
        self.maskColor = maskColor
        super.init(frame: CGRectMake(30, 10, 200, 40))

        self.addUserName()
        self.addStar()
    }

    func addUserName() {
        let label = UILabel(frame: CGRectMake(0,0,100,20))
            label.text = thisUser.name
            label.font = UIFont(name: "ArialHebrew-Bold", size: 15)
            label.textColor = UIColor.whiteColor()
            label.sizeToFit()

        self.addSubview(label)
    }

    func addStar() {
        var starNum = thisUser.star
        let width: CGFloat = 25;

        while starNum > 0 {
            let star = UIImageView(frame: CGRectMake(CGFloat(thisUser.star-starNum)*width, 20, width, width))
                star.image = UIImage(named: "star")

            starNum--
            if starNum < 0 {
                let mask = CALayer()
                    mask.backgroundColor = maskColor.CGColor
                    mask.frame = CGRectMake(CGFloat(1+starNum)*width, 0, CGFloat(abs(starNum))*width, width)

                star.layer.addSublayer(mask)
            }

            self.addSubview(star)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
