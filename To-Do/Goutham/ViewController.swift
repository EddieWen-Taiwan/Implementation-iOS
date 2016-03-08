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
            getAllTask()
        } catch {
            fatalError("Failture : \(error)")
        }
    }

    func handleTaskStatus(sender: UIButton) {
        let cell = tableView.cellForRowAtIndexPath( NSIndexPath(forRow: sender.tag, inSection: 0) ) as! TaskTableCell

        let updateQuery = NSFetchRequest(entityName: "ToDo")
            updateQuery.predicate = NSPredicate(format: "task = %@", cell.taskLabel.text!)

        do {
            let result = try moc.executeFetchRequest(updateQuery) as! [ToDo]

            if let result: ToDo = result[0] {
                sender.setImage(UIImage(named: result.checked == true ? "unchecked" : "checked"), forState: .Normal)
                result.checked = result.checked == true ? false : true

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

}

