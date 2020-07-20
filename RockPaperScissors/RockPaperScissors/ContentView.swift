//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Japneet Singh on /207/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var playerMove = 0
    @State private var appMove = Int.random(in: 0...2)
    @State private var resultMessage = "Lets Start"
    @State private var score = 0
    @State private var moveCount = 0
    @State private var showAlert = false
    
    enum Result {
        case win
        case lose
        case tie
    }
    
    var moves = ["Rock", "Paper", "Scissors"]
    
    func reset(){
        score = 0
        moveCount = 0
        resultMessage = "Lets Start"
    }
    
    func result(){
        moveCount += 1
        
        if(appMove==playerMove){
            resultMessage = "Its a Tie!"
        }
        else if (appMove == playerMove - 1 || appMove == 2 && playerMove == 0){
            resultMessage = "Wow! You Won!"
            score += 1
        }
        else{
            resultMessage = "Sorry :( You lost!"
        }
        
        if(moveCount==10){
            showAlert = true
            showAlert = true
        }
        
    }
    
    
    var body: some View {
        
        VStack(spacing: 30){
            Text("Score: \(score) / \(moveCount)").font(.title).fontWeight(.bold)
            Text("\(resultMessage)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(resultMessage == "Wow! You Won!" ? Color.green : resultMessage == "Sorry :( You lost!" ? Color.red : Color.black)
            moveCount > 0 ? Text("App chose \(moves[appMove])") : Text("")
            moveCount > 0 ? Text("You chose \(moves[playerMove])") : Text("Tap to choose a move")
            HStack(spacing: 30){
                VStack {
                    Button(action: {
                        self.playerMove = 0
                        self.appMove = Int.random(in: 0...2)
                        self.result()
                    }){
                        Image(systemName: "circle.fill").font(.largeTitle).accentColor(.primary)
                    }
                    Text("\(moves[0])")
                }
                VStack {
                    Button(action: {
                        self.playerMove = 1
                        self.appMove = Int.random(in: 0...2)
                        self.result()
                    }){
                        Image(systemName: "square.fill").font(.largeTitle).accentColor(.primary)
                    }
                    Text("\(moves[1])")
                }
                VStack {
                    Button(action: {
                        self.playerMove = 2
                        self.appMove = Int.random(in: 0...2)
                        self.result()
                    }){
                        Image(systemName: "scissors").font(.largeTitle).accentColor(.primary)
                    }
                    Text("\(moves[2])")
                }
            }
        }.alert(isPresented: $showAlert){
            Alert(title: Text("Game Over"), message: Text("You scored \(score) out of 10"), dismissButton: .default(Text("Play Again")){
                self.reset()
                })
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
