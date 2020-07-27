//
//  Expenses.swift
//  iExpense
//
//  Created by Japneet Singh on /277/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

class Expenses: ObservableObject{
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        self.items = []
    }
    
    
    @Published var items: [ExpenseItem] {
    didSet {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
        
    
    }
}
