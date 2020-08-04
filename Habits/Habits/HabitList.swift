//
//  HabitList.swift
//  Habits
//
//  Created by Japneet Singh on /48/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import Foundation

class HabitList: ObservableObject {
    @Published var list = [Habit]()
}
