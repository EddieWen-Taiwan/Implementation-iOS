//
//  ViewController.swift
//  Goutham
//
//  Created by Eddie on 2/26/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let titleArray = ["STAY", "TRACK", "DO THINGS"]
    let descArray = ["ANONYMOUS", "LOCATION", "MORE FASTER"]
    let imgArray = ["pic1", "pic2", "pic3"]
    let bgArray = ["bg1", "bg2", "bg3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataSource = self

        setViewControllers([viewcontrollerAtIndex(0)], direction: .Forward, animated: true, completion: nil)
    }

    func viewcontrollerAtIndex(index: Int) -> PageContentViewController {
        let contentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController

            contentViewController.bgImgName = bgArray[index]
            contentViewController.imageName = imgArray[index]
            contentViewController.titleText = titleArray[index]
            contentViewController.descText = descArray[index]
            contentViewController.pageIndex = index

        return contentViewController
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let curIndex = (viewController as? PageContentViewController)?.pageIndex {
            if curIndex == 0 {
                return nil
            } else {
                print("Left-AFTER: \(curIndex-1)")
                return viewcontrollerAtIndex( curIndex-1 )
            }
        } else {
            return nil
        }
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let curIndex = (viewController as? PageContentViewController)?.pageIndex {
            if curIndex == titleArray.count - 1 {
                return nil
            } else {
                print("Right-AFTER: \(curIndex+1)")
                return viewcontrollerAtIndex( curIndex+1 )
            }
        } else {
            return nil
        }
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return titleArray.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

