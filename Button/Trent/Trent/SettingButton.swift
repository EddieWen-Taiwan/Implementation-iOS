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
    var barArray = [UIView]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = frame.width*0.05
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = 10

        addThreeColumn( frame.width )
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let height = self.frame.width*4/5-10
        UIView.animateWithDuration( 0.2, animations: {
            self.barArray[0].frame.origin.y = height*0.2+5
            self.barArray[1].frame.origin.y = height*0.7+5
            self.barArray[2].frame.origin.y = height*0.35+5
        }, completion: { finish in
            UIView.animateWithDuration( 0.2, animations: {
                self.barArray[0].frame.origin.y = height*self.initValue[0]+5
                self.barArray[1].frame.origin.y = height*self.initValue[1]+5
                self.barArray[2].frame.origin.y = height*self.initValue[2]+5
                self.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            })
        })
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
                barArray.append(bar)
            column.addSubview(bar)

            self.addSubview(column)
        }

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}