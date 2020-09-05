//
//  Result.swift
//  BucketList
//
//  Created by Japneet Singh on /59/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
