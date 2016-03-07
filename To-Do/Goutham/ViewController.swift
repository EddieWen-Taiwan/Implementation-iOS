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
            let results = try moc.executeFetchRequest(query) as! [ToDo]
            for result in results {
                print(result)
                print("TASK : \(result.task) & CHECKED : \(result.checked)")
            }
        } catch {
            fatalError("Oops! \(error)")
        }
    }

    @IBAction func addNewTask(sender: AnyObject) {
        let newTaskController = UIAlertController(title: "New Task", message: "Add a new to-do task", preferredStyle: .Alert)
        let ok = UIAlertAction(title: "Ok", style: .Default, handler: { action -> Void in
            if let textfield = newTaskController.textFields {
                if textfield[0].text != "" {
                    let newTodo = textfield[0].text!
                    print(newTodo)
                    let todo = NSEntityDescription.insertNewObjectForEntityForName("ToDo", inManagedObjectContext: self.moc) as! ToDo
                        todo.task = newTodo
                        todo.checked = false

                    do {
                        try self.moc.save()
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
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath) as! TaskTableCell

        cell.checkButton.addTarget(self, action: "handleTaskStatus:", forControlEvents: .TouchUpInside)
        return cell
    }

    func handleTaskStatus(sender: UIButton) {
        sender.setImage(UIImage(named: "checked"), forState: .Normal)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

