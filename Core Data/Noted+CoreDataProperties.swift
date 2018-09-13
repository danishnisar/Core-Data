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


extension Noted {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Noted> {
        return NSFetchRequest<Noted>(entityName: "Noted")
    }

    @NSManaged public var message: String
    @NSManaged public var id: Int16

}
