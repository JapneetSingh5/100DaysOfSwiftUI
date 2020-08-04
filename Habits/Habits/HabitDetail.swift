//
//  HabitDetail.swift
//  Habits
//
//  Created by Japneet Singh on /48/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct HabitDetail: View {

    @ObservedObject var habitList: HabitList
    let habitNo: Int

    
    
//    init(habit: Habit){
//        self.habit = habit
//        self.count = habit.count
//    }

    var body: some View {
        NavigationView{
        VStack{
            ZStack{
                Circle()
                    .fill(RadialGradient(gradient: Gradient(colors: [.red, .orange]), center: .center, startRadius: 100, endRadius: 200))
                    .padding()
                VStack{
                    Text(habitList.list[habitNo].name)
                        .foregroundColor(.white)
                    Text("\(habitList.list[habitNo].count) Days")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text("of \(habitList.list[habitNo].target) Days")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    Text(habitList.list[habitNo].emoji).font(.largeTitle)
                }.scaleEffect(1.5)
            }
            Stepper("Change Tally", value: $habitList.list[habitNo].count)
                .font(.title)
                .foregroundColor(.white)
            .padding()
            .background(Color.orange)
            .cornerRadius(20)
            .padding()
            }
        .navigationBarTitle(habitList.list[habitNo].name)
        }
    }
}

struct HabitDetail_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetail(habitList: HabitList(), habitNo: 0)
    }
}
