//
//  Employ+CoreDataProperties.swift
//  Core Data
//
//  Created by MacBook Prp on 11/09/2018.
//  Copyright © 2018 Native Brains. All rights reserved.
//
//

import Foundation
import CoreData


extension Employ {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employ> {
        return NSFetchRequest<Employ>(entityName: "Employ")
    }

    @NSManaged public var message: String?

}
