//
//  ToDo+CoreDataProperties.swift
//  Goutham
//
//  Created by Eddie on 3/7/16.
//  Copyright © 2016 Wen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ToDo {

    @NSManaged var task: String?
    @NSManaged var checked: NSNumber?

}
