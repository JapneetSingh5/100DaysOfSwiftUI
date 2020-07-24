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
    @State private var flagRotationRight: Double = 0
    @State private var flagRotationWrong: Double = 0
    @State private var jumpOffset: CGFloat = 0
    @State private var opacity: Double = 0.9
    @State private var submit: Bool = false
    
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
                        self.submit = true
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                                .renderingMode(.original)
                            .flagImage().opacity(number != self.correctAnswer ? self.opacity : 0.9)
                    }.rotation3DEffect( Angle.degrees(number==self.correctAnswer ? self.flagRotationRight : self.flagRotationWrong), axis: number==self.correctAnswer ? (x:0, y:1,z:0) : (x:1, y:0,z:0))
                        .offset(y: number == self.correctAnswer ? self.jumpOffset : 0)
                        
                }
                Text("Score: \(correctCount) / \(questionCount)").fontWeight(.black).font(.headline).foregroundColor(.white)
                if questionCount>0 {
                    Text("\(scoreTitle)").font(.headline).foregroundColor(.white)
                    if(self.submit){
                        Button("Continue"){
                        self.askQuestion()
                            self.submit = false
                                }
                    }
                }
                Spacer()
            }
        }
    }
    
    func flagTapped(_ number: Int){
        questionCount += 1
        if number==correctAnswer{
            scoreTitle = "Correct! Great job!"
            correctCount += 1
            withAnimation(
                Animation.easeInOut(duration: 1)
            ){
                 self.flagRotationRight += 360
                 self.opacity = 0.25
            }
            self.submit = true
        }else{
            scoreTitle = "Wrong :( That was the flag of \(countries[number])"
            self.opacity = 0.25
            withAnimation(
                Animation.easeInOut(duration: 1).repeatCount(1, autoreverses: true)
            ){
                 self.flagRotationWrong += 360
                 self.jumpOffset += -10
            }
            self.submit = true
        }
        showingScore = true
    }
    
    func askQuestion(){
        self.jumpOffset = 0
        self.flagRotationRight = 0
        self.flagRotationWrong = 0
        self.opacity = 1.0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
