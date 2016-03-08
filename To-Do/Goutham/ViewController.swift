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

    @IBOutlet var tableView: UITableView!

    @IBOutlet var newTaskButton: UIButton!

    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var taskList = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self

        newTaskButton.layer.cornerRadius = 30
        getAllTask()
    }

    func getAllTask() {
        let query = NSFetchRequest(entityName: "ToDo")

        do {
            taskList = try moc.executeFetchRequest(query) as! [ToDo]
            tableView.reloadData()
        } catch {
            fatalError("Oops! \(error)")
        }
    }

    @IBAction func addNewTask(sender: AnyObject) {
        let newTaskController = UIAlertController(title: "New Task", message: "Add a new to-do task", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Ok", style: .Default, handler: { action -> Void in
            if let textfield = newTaskController.textFields {
                if textfield[0].text != "" {
                    let todo = NSEntityDescription.insertNewObjectForEntityForName("ToDo", inManagedObjectContext: self.moc) as! ToDo
                        todo.task = textfield[0].text!
                        todo.checked = false

                    do {
                        try self.moc.save()
                        self.getAllTask()
                    } catch {
                        fatalError("Failture : \(error)")
                    }
                }
            }
        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        newTaskController.addAction(ok)
        newTaskController.addAction(cancel)
        newTaskController.addTextFieldWithConfigurationHandler{ (textField) -> Void in
            textField.placeholder = "Enter your next ToDo"
        }
        self.presentViewController(newTaskController, animated: true, completion: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskTableCell

        cell.taskLabel.text = taskList[indexPath.row].task
        cell.checkButton.setImage(UIImage(named: taskList[indexPath.row].checked == true ? "checked" : "unchecked"), forState: .Normal)
        cell.checkButton.addTarget(self, action: "handleTaskStatus:", forControlEvents: .TouchUpInside)
        cell.checkButton.tag = indexPath.row

        return cell
    }

    func handleTaskStatus(sender: UIButton) {
//        sender.setImage(UIImage(named: "checked"), forState: .Normal)
        print(sender.tag)
        let cell = tableView.cellForRowAtIndexPath( NSIndexPath(forRow: sender.tag, inSection: 0) ) as! TaskTableCell
        print(cell.taskLabel.text)

        let updateQuery = NSFetchRequest(entityName: "ToDo")
            updateQuery.predicate = NSPredicate(format: "task = %@", cell.taskLabel.text!)
        do {
            let result = try moc.executeFetchRequest(updateQuery) as! [ToDo]

            if result.count > 0 {
                print(result[0])
            }
        } catch {
            fatalError("Update fail : \(error)")
        }
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

