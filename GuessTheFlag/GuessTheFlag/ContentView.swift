//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Japneet Singh on /197/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.black, radius: 2)
    }
}

extension View {
    func flagImage() -> some View{
        self.modifier(FlagImage())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var correctCount = 0
    @State private var questionCount = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30.0){
                VStack {
                    Text("Tap the flag of ..").foregroundColor(.white)
                    Text(countries[correctAnswer]).foregroundColor(.white).font(.largeTitle).fontWeight(.black).edgesIgnoringSafeArea(.all).frame(width: 300)
                }
                ForEach( 0..<3){ number in
                    Button(action: {
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                                .renderingMode(.original)
                                .flagImage()
                        
                    }
                }
                Text("Score: \(correctCount) / \(questionCount)").fontWeight(.black).font(.headline).foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Your score is \(correctCount)/\(questionCount)"), dismissButton: .default(Text("Continue")){
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int){
        questionCount += 1
        if number==correctAnswer{
            scoreTitle = "Correct! Great job!"
            correctCount += 1
        }else{
            scoreTitle = "Wrong :( That is the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
