//
//  AddHabit.swift
//  Habits
//
//  Created by Japneet Singh on /48/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct AddHabit: View {
    let targets = ["7", "21", "50", "Custom"]
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habitList: HabitList
    @State private var name: String = ""
    @State private var category: Int = 0
    @State private var emoji: String = ""
    @State private var count: Int = 0
    @State private var targetIndex: Int = 0
    @State private var targetChoice: String = ""
    private var target: Int {
        if targetIndex<3{
            return Int(targets[targetIndex]) ?? 0
        }
        else {
            return Int(targetChoice) ?? 0
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Name the habit you want to inculcate")){
                    TextField("Habit Name", text: $name)
                    Picker("Category", selection: $category){
                        ForEach(0..<Habit.category.count){
                            Text(Habit.category[$0])
                        }
                    }
                    TextField("Emoji", text: $emoji)
                }
                
                Section(header: Text("Describe your habit goals")){
                    Section(header: Text("Current Tally")){
                        Stepper("\(count) Days", value: $count)
                    }
                    Section(header: Text("Target")){
                        Picker("Category", selection: $targetIndex){
                            ForEach(0..<self.targets.count){
                                Text("\(self.targets[$0]) Days")
                            }}            .pickerStyle(SegmentedPickerStyle())

                            if(targetIndex == 3){
                                TextField("Custom Target (Integer)", text: $targetChoice)
                                    .keyboardType(.numberPad)
                            }
                    }
                }
                
                Button("Save"){
                    self.habitList.list.append(
                        Habit( name: self.name, category: Habit.category[self.category], count: self.count, target: self.target))
                    self.presentationMode.wrappedValue.dismiss()
                }
                Button("Cancel"){
                    self.presentationMode.wrappedValue.dismiss()
                }.foregroundColor(.red)
            }
            .navigationBarTitle(name == "" ? "New Habit" : name )
        }

    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habitList: HabitList())
    }
}
