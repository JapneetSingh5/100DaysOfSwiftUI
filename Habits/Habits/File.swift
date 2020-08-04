//
//  File.swift
//  Habits
//
//  Created by Japneet Singh on /48/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation


class HabitList: ObservableObject{
    
    init() {
        if let list = UserDefaults.standard.data(forKey: "list") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: list) {
                self.list = decoded
                return
            }
        }

        self.list = []
    }
    
    @Published var list: [Habit] {
    didSet {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(list) {
            UserDefaults.standard.set(encoded, forKey: "list")
        }
    }
    }
    

}
