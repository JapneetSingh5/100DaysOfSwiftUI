//
//  Tag+CoreDataProperties.swift
//  FriendsCoreData
//
//  Created by Japneet Singh on /228/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tag: String?
    @NSManaged public var tags: NSSet?
    
    public var wrappedTag: String {
        tag ?? "Unknown"
    }

}

// MARK: Generated accessors for tags
extension Tag {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: User)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: User)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
