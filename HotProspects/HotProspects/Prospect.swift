//
//  Prospect.swift
//  HotProspects
//
//  Created by Japneet Singh on /169/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init(){
        self.people = [Prospect]()
    }
}
