//
//  Friend+CoreDataProperties.swift
//  FriendsCoreData
//
//  Created by Japneet Singh on /228/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: User?
    
    public var wrappedId: String{
        id ?? "Uknown"
    }
    public var wrappedName: String{
        name ?? "Unknown"
    }

}
