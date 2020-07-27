//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Japneet Singh on /277/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable{
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
}
