//
//  SettingButton.swift
//  Trent
//
//  Created by Eddie on 2/26/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class SettingButton: UIButton {

    let initValue: [CGFloat] = [0.7, 0.2, 0.5]

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = frame.width*0.05
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = 10

        addThreeColumn( frame.width )
    }

    func addThreeColumn( width: CGFloat ) {

        let newWidth = width*4/5
        let gap = width/5/2
        let colWidth = newWidth/3

        for i in 1...3 {
            let column = UIView(frame: CGRectMake(gap, gap, colWidth, newWidth))
                column.frame.origin.x = gap + newWidth/3*CGFloat(i-1)

            let line = UIView(frame: CGRectMake(0, 5, colWidth/4, newWidth-10))
                line.frame.origin.x = colWidth/2-colWidth/8
                line.backgroundColor = UIColor.whiteColor()
                line.layer.cornerRadius = colWidth/4/2
            column.addSubview(line)

            let bar = UIView(frame: CGRectMake(2, (newWidth-10)*initValue[i-1]+5, colWidth-4, (newWidth-10)/10))
                bar.backgroundColor = UIColor.whiteColor()
                bar.layer.cornerRadius = (newWidth-10)/10/2
            column.addSubview(bar)

            self.addSubview(column)
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}