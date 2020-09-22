//
//  Resort.swift
//  SnowSeeker
//
//  Created by Japneet Singh on /229/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable {
    enum SortBy{
        case none, alphabetical, country
    }
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    static func sort(key: SortBy, resorts: [Resort]) -> [Resort]{
        switch(key){
        case .none:
            return resorts
        case .alphabetical:
            return resorts.sorted(by: {
                $0.name < $1.name
            })
        case .country:
            return resorts.sorted(by: {
                $0.country < $1.country
            })
        }
    }

}

