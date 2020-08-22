//
//  User.swift
//  Friends
//
//  Created by Japneet Singh on /208/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String 
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}
