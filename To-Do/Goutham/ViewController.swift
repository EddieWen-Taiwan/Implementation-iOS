//
//  ViewController.swift
//  Goutham
//
//  Created by Eddie on 3/7/16.
//  Copyright © 2016 Wen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /***
     *  Core Data
     *  TableView and Cell
    ***/

    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var taskList = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self

        newTaskButton.layer.cornerRadius = 30
        getAllTask()

        setTodayInfo()

        // Add gesture
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPressOnTableView:")
        tableView.addGestureRecognizer( longPress )
    }

    func getAllTask(add: Bool = false) {
        let query = NSFetchRequest(entityName: "ToDo")

        do {
            taskList = try moc.executeFetchRequest(query) as! [ToDo]
            if add {
                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: taskList.count-1, inSection: 0)], withRowAnimation: .Right)
            } else {
                tableView.reloadData()
            }
        } catch {
            fatalError("Oops! \(error)")
        }
    }

    func handleTaskStatus(sender: UIButton) {
        let cell = tableView.cellForRowAtIndexPath( NSIndexPath(forRow: sender.tag, inSection: 0) ) as! TaskTableCell

        let updateQuery = NSFetchRequest(entityName: "ToDo")
            updateQuery.predicate = NSPredicate(format: "task = %@", cell.taskLabel.text!)

        do {
            let result = try moc.executeFetchRequest(updateQuery) as! [ToDo]

            if let result: ToDo = result[0] {
                result.checked = result.checked == true ? false : true
                sender.setImage(UIImage(named: result.checked == true ? "checked" : "unchecked"), forState: .Normal)
                cell.taskLabel.textColor = result.checked == true ? UIColor(red: 189/255, green: 192/255, blue: 202/255, alpha: 1) : UIColor(red: 62/255, green: 67/255, blue: 79/255, alpha: 1)

                try moc.save()
            }
        } catch {
            fatalError("Update fail : \(error)")
        }
    }

    func deleteTask( index: NSIndexPath ) {
        let cell = tableView.cellForRowAtIndexPath( index ) as! TaskTableCell
        let query = NSFetchRequest(entityName: "ToDo")
            query.predicate = NSPredicate(format: "task = %@", cell.taskLabel.text!)
        do {
            let result = try moc.executeFetchRequest(query) as! [ToDo]

            if let result: ToDo = result[0] {
                moc.deleteObject(result)

                try moc.save()
                getAllTask()
            }
        } catch {
            fatalError("Delete fail : \(error)")
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskTableCell

        cell.taskLabel.textColor = taskList[indexPath.row].checked == true ? UIColor(red: 189/255, green: 192/255, blue: 202/255, alpha: 1) : UIColor(red: 62/255, green: 67/255, blue: 79/255, alpha: 1)
        cell.taskLabel.text = taskList[indexPath.row].task
        cell.checkButton.setImage(UIImage(named: taskList[indexPath.row].checked == true ? "checked" : "unchecked"), forState: .Normal)
        cell.checkButton.addTarget(self, action: "handleTaskStatus:", forControlEvents: .TouchUpInside)
        cell.checkButton.tag = indexPath.row

        return cell
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteTask( indexPath )
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    /***
     *  Gesture
    ***/

    func longPressOnTableView(gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let pressState = longPress.state
        let locationPoint = longPress.locationInView(tableView)

        struct My {
            static var cellSnapshot: UIView? = nil
            static var initialIndexPath: NSIndexPath? = nil
        }

        if let cellIndexPath = tableView.indexPathForRowAtPoint(locationPoint) {
            switch pressState {
            case UIGestureRecognizerState.Began:
                My.initialIndexPath = cellIndexPath
                let thisCell = tableView.cellForRowAtIndexPath(cellIndexPath) as UITableViewCell!
                My.cellSnapshot = takeSnapshotOfCell(thisCell)
                var center = thisCell.center
                My.cellSnapshot?.center = center
                My.cellSnapshot?.alpha = 0
                tableView.addSubview( My.cellSnapshot! )
                UIView.animateWithDuration( 0.25, animations: {
                    center.y = locationPoint.y
                    My.cellSnapshot!.center = center
                    My.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    thisCell.alpha = 0.0
                }, completion: { finished -> Void in
                    if finished {
                        thisCell.hidden = true
                    }
                })
            case UIGestureRecognizerState.Changed:
                My.cellSnapshot?.center.y = locationPoint.y
                if cellIndexPath != My.initialIndexPath {
                    swap( &taskList[cellIndexPath.row], &taskList[My.initialIndexPath!.row] )
                    tableView.moveRowAtIndexPath(My.initialIndexPath!, toIndexPath: cellIndexPath)
                    My.initialIndexPath = cellIndexPath
                }
            default:
                let cell = tableView.cellForRowAtIndexPath(cellIndexPath) as! TaskTableCell
                cell.hidden = false
                cell.alpha = 0
                UIView.animateWithDuration( 0.25, animations: {
                    My.cellSnapshot?.center = cell.center
                    My.cellSnapshot?.transform = CGAffineTransformIdentity
                    My.cellSnapshot?.alpha = 0
                    cell.alpha = 1
                }, completion: { finish in
                    if finish {
                        My.initialIndexPath = nil
                        My.cellSnapshot?.removeFromSuperview()
                        My.cellSnapshot = nil
                    }
                })
            }
        }
    }

    func takeSnapshotOfCell(cellView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(cellView.bounds.size, false, 0.0)
        cellView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        UIGraphicsEndImageContext()

        let cellSnapshot : UIView = UIImageView(image: image)
            cellSnapshot.layer.masksToBounds = false
            cellSnapshot.layer.cornerRadius = 0.0
            cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
            cellSnapshot.layer.shadowRadius = 5.0
            cellSnapshot.layer.shadowOpacity = 0.4

        return cellSnapshot
    }

    /***
     *   Today Info
    ***/

    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!

    func setTodayInfo() {
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
            calendar.timeZone = NSTimeZone.localTimeZone()
        let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy/MMM/dd/EEEE"
        let dateArray = dateFormatter.stringFromDate(today).characters.split{ $0 == "/" }.map(String.init)

        yearLabel.text = dateArray[0]
        monthLabel.text = dateArray[1].uppercaseString
        dateLabel.text = dateArray[2]
        dayLabel.text = dateArray[3].uppercaseString
    }

    /***
     *  Add New ToDo Task
    ***/

    @IBOutlet var tableView: UITableView!
    @IBOutlet var newTaskButton: UIButton!

    @IBAction func showNewTaskAlert(sender: AnyObject) {
        let newTaskController = UIAlertController(title: "New Task", message: "Add a new to-do task", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Ok", style: .Default, handler: { action -> Void in
            if let textfield = newTaskController.textFields where textfield[0].text != "" {
                self.addNewTask( textfield[0].text! )
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        newTaskController.addAction(ok)
        newTaskController.addAction(cancel)
        newTaskController.addTextFieldWithConfigurationHandler{ textField -> Void in
            textField.placeholder = "Enter your next ToDo"
        }
        self.presentViewController(newTaskController, animated: true, completion: nil)
    }

    func addNewTask( newTask: String ) {
        let todo = NSEntityDescription.insertNewObjectForEntityForName("ToDo", inManagedObjectContext: self.moc) as! ToDo
            todo.task = newTask
            todo.checked = false

        do {
            try self.moc.save()
            getAllTask(true)
        } catch {
            fatalError("Failture : \(error)")
        }
    }

}

