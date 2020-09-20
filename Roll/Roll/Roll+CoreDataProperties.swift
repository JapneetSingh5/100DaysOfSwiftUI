//
//  Roll+CoreDataProperties.swift
//  Roll
//
//  Created by Japneet Singh on /209/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//
//

import Foundation
import CoreData


extension Roll {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Roll> {
        return NSFetchRequest<Roll>(entityName: "Roll")
    }

    @NSManaged public var sides: Int16
    @NSManaged public var diceCount: Int16
    @NSManaged public var result: Int16

}
