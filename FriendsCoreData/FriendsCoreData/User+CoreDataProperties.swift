//
//  User+CoreDataProperties.swift
//  FriendsCoreData
//
//  Created by Japneet Singh on /228/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//
//

import Foundation
import CoreData


extension User{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: String?
    @NSManaged public var friends: NSSet?
    @NSManaged public var userTags: NSSet?
    
    public var wrappedId: String{
        id ?? "Uknown"
    }
    public var wrappedName: String{
        name ?? "Unknown"
    }
    public var wrappedCompany: String{
        company ?? "Unknown"
    }
    public var wrappedEmail: String{
        email ?? "Unkown"
    }
    public var wrappedAddress: String{
        address ?? "Unknown Address"
    }
    public var wrappedAbout: String{
        about ?? "Unknown About Description"
    }
    public var wrappedRegistered: String{
        registered ?? "2020-01-01T00:00:00-00:00"
    }
    
    public var wrappedFriends: [Friend]{
        let set = friends as? Set<Friend> ?? []
        return set.sorted{
            $0.wrappedId < $1.wrappedId
        }
    }
    
    public var wrappedTags: [Tag]{
        let set = userTags as? Set<Tag> ?? []
        return set.sorted{
            $0.wrappedTag < $1.wrappedTag
        }
    }

}

// MARK: Generated accessors for friends
extension User {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

// MARK: Generated accessors for userTags
extension User {

    @objc(addUserTagsObject:)
    @NSManaged public func addToUserTags(_ value: Tag)

    @objc(removeUserTagsObject:)
    @NSManaged public func removeFromUserTags(_ value: Tag)

    @objc(addUserTags:)
    @NSManaged public func addToUserTags(_ values: NSSet)

    @objc(removeUserTags:)
    @NSManaged public func removeFromUserTags(_ values: NSSet)

}
