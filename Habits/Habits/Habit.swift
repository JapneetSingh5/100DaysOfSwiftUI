//
//  Habit.swift
//  Habits
//
//  Created by Japneet Singh on /48/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

struct Habit: Identifiable {
    let id = UUID()
    let emoji: String
    var name: String
    var category: String
    var count: Int = 0
    var target: Int = 0
}
