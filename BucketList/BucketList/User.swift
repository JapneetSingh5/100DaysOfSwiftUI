//
//  User.swift
//  BucketList
//
//  Created by Japneet Singh on /19/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

import Foundation

struct User: Comparable, Identifiable {
    
    var id = UUID()
    var firstName: String
    var lastName: String
    
    static func < (lhs: User, rhs: User) -> Bool{
        return lhs.lastName < rhs.lastName
    }
}


