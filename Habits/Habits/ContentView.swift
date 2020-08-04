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
                
                ForEach(0..<habitList.list.count, id:\.self){ habitNo in
                    NavigationLink( destination:
                    HabitDetail(habitList: self.habitList, habitNo: habitNo)){
                        HStack {
                            Text(self.habitList.list[habitNo].emoji)
                            VStack(alignment: .leading){
                                Text(self.habitList.list[habitNo].name)
                                    .font(.headline)
                                Text(self.habitList.list[habitNo].category)
                                    .font(.subheadline)
                            }
                            Spacer()
                            Spacer()
                            VStack{
                                Text("\(self.habitList.list[habitNo].count) Days").font(.title)
                                Text("of \(self.habitList.list[habitNo].target) Days").font(.caption)
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
