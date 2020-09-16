//
//  Prospect.swift
//  HotProspects
//
//  Created by Japneet Singh on /169/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

class Prospect: Identifiable, Codable, Comparable {
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        (lhs.name == rhs.name) && (lhs.emailAddress == rhs.emailAddress)
    }
    
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    
}

class Prospects: ObservableObject{
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData"
    
    init(){
        self.people = []
        
        let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
         
        do {
            let data = try Data(contentsOf: filename)
            print("File found")
            print(data.description)
            self.people = try JSONDecoder().decode([Prospect].self, from: data)
            print("Data loaded")
        } catch {
            print("Unable to load saved data.")
        }
    }
    
//    init(){
//
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                self.people = decoded
//                return
//            }
//        }
//
//        self.people = [Prospect]()
//    }
    
    private func save() {
        do{
            let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(self.people)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Data saved")
        }catch{
            print("Unable to save data")
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        self.save()
    }
    
    func add(_ prospect: Prospect) {
        people.insert(prospect, at: 0)
        save()
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}
