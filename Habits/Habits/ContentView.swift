//
//  ContentView.swift
//  Habits
//
//  Created by Japneet Singh on /48/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habitList = HabitList()
    @State private var showAddHabit: Bool = false
    
    func removeHabits(at offsets: IndexSet){
        habitList.list.remove(atOffsets: offsets)
    }
    var body: some View {
        NavigationView{
            List{
                
                ForEach(habitList.list){ habit in
                    NavigationLink(destination: Text("Detailed Habit")){
                        HStack {
                            Text(habit.emoji)
                            VStack(alignment: .leading){
                                Text(habit.name)
                                    .font(.headline)
                                Text(habit.category)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Spacer()
                            VStack{
                                Text("\(habit.count) Days").font(.title)
                                Text("of \(habit.target) Days").font(.caption)
                            }
                        }.padding(.leading, 10).padding(.trailing, 10)
                    }
                }
                .onDelete(perform: removeHabits)
                
                HStack{
                    Spacer()
                    Button("Add New Habit"){
                        self.showAddHabit.toggle()
                    }.foregroundColor(.blue)
                    Spacer()
                }
            }
        .navigationBarTitle("Habits")
            .navigationBarItems(leading: EditButton())
            .sheet(isPresented: $showAddHabit){
                AddHabit(habitList: self.habitList)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
