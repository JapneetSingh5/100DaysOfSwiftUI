//
//  ContentView.swift
//  NumberFarm
//
//  Created by Japneet Singh on /257/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct Question {
    var number: Int
    var answer: Int
}

let animals = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale" , "zebra"]

struct ContentView: View {
    @State private var gameOver: Bool = true
    @State private var chosenNumber: Int = 0
    @State private var difficultyLevel: Int = 0
    @State private var numberOfQuestions: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .yellow, .orange, .red]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                if gameOver{
                    SettingScreen(gameOver: $gameOver, chosenNumber: $chosenNumber, difficultyLevel: $difficultyLevel, numberOfQuestions: $numberOfQuestions)
                }
                if !gameOver{
                    Button("End Game"){
                        self.gameOver.toggle()
                    }.padding(20).background(Color.red)
                    .cornerRadius(20).foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                }
            }
        }
    }
}

struct SettingScreen: View {
    @Binding var gameOver: Bool
    @Binding var chosenNumber: Int
    let difficultyLevels = ["Easy", "Medium", "Difficult"]
    @Binding var difficultyLevel : Int
    let availableNumberOfQuestions = ["5", "10", "20", "All"]
    @Binding var numberOfQuestions : Int
    var body: some View{
        VStack{
            Group{
                Spacer()
                Text("NUMBER FARM").font(.system(size: 44, weight: .black, design: .rounded)).foregroundColor(.white)
            }
            Image(animals.randomElement() ?? "moose")
            Spacer()
            Text("Settings").font(.title).fontWeight(.bold).padding()
            Section(header: Text("Choose the number you like")){
                Picker("Choose your number", selection: $chosenNumber){
                ForEach(1..<13){
                    Text("\($0)")
                }
                }.pickerStyle(SegmentedPickerStyle()).cornerRadius(9).padding()
            }
            Section(header: Text("Choose a difficulty level")){
                Picker("Choose your number", selection: $difficultyLevel){
                    ForEach(0..<difficultyLevels.count){
                        Text(self.difficultyLevels[$0])
                }
                }.pickerStyle(SegmentedPickerStyle()).cornerRadius(8).padding()
            }
            Section(header: Text("How many questions would you like?")){
                Picker("Choose your number", selection: $numberOfQuestions){
                    ForEach(0..<availableNumberOfQuestions.count){
                        Text(self.availableNumberOfQuestions[$0])
                }
                }.pickerStyle(SegmentedPickerStyle()).cornerRadius(8).padding()
            }
            Spacer()
            Button("Start Game"){
                self.gameOver.toggle()
            }
            .padding(20)
            .background(Color.green)
            .cornerRadius(20)
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .bold, design: .rounded))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
