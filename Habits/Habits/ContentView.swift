//
//  ContentView.swift
//  Habits
//
//  Created by Japneet Singh on /48/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var habitList: HabitList = HabitList()
    
    func removeHabits(at offsets: IndexSet){
        habitList.list.remove(atOffsets: offsets)
    }
    var body: some View {
        NavigationView{
            List{
                
                ForEach(0..<5){ _ in
                    NavigationLink(destination: Text("Detailed Habit")){
                        HStack {
                            Text("💻")
                            VStack(alignment: .leading){
                                Text("100 Days Of Code")
                                    .font(.headline)
                                Text("Developer Goals")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Spacer()
                            VStack{
                                Text("63 Days").font(.title)
                                Text("of 100 Days").font(.caption)
                            }
                        }.padding(.leading, 10).padding(.trailing, 10)
                    }
                }
                .onDelete(perform: removeHabits)
                
                HStack{
                    Spacer()
                    Button("Add New Habit"){
                        print("Adding New Habit")
                    }.foregroundColor(.blue)
                    Spacer()
                }
            }
        .navigationBarTitle("Habits")
            .navigationBarItems(leading: EditButton())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
