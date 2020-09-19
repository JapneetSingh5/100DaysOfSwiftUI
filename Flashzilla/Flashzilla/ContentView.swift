//
//  ContentView.swift
//  Flashzilla
//
//  Created by Japneet Singh on /179/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import CoreHaptics

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self
                .offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView: View {
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    @State private var isActive = true
    @State private var showingSheet = false
    @State private var showingSettingsScreen = false
    @State private var sendToBack = true
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func removeCard(at index: Int) {
        if cards.isEmpty {
            isActive = false
        }
        cards.remove(at: index)

    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    var body: some View {
        
        ZStack {
            
            Image(decorative: "background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text(timeRemaining>0 ? "Time: \(timeRemaining)" : "Oops! You are out of time!")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(Color.black)
                        .opacity(0.75)
                )
                
                if timeRemaining>0 {
                    ZStack {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(sendToBack: self.$sendToBack, card: self.cards[index], sendToBackFunc: {
                                let temp = self.cards[self.cards.count - 1]
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                               self.cards.insert(temp, at: 0)
                                           }
                                print("card added to back")
                            }, removal: {
                                withAnimation {
                                    self.removeCard(at:index)
                                      }
                                print("top card removed")
                            })
                            .allowsHitTesting(index == self.cards.count-1)
                            .accessibility(hidden: index < self.cards.count - 1)
                            .stacked(at: index, in: self.cards.count)
                        }
                    }
                    .allowsHitTesting(timeRemaining > 0)
                }
                
                if cards.isEmpty || timeRemaining==0 {
                    withAnimation{
                        Button("Start Again", action: resetCards)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                        .padding()
                    }
                }
                

            }
            
            VStack {
                HStack {
                    Button(action: {
                        self.showingSettingsScreen = true
                        self.showingSheet = true
                    }){
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()

                    Button(action: {
                        self.showingSettingsScreen = false
                        self.showingSheet = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled { 
                VStack {
                    Spacer()

                    HStack {
                        if (self.cards.count > 0) {
                            Button(action: {
                            withAnimation {
                                if self.sendToBack{
                                    self.cards.insert(self.cards[self.cards.count - 1], at: 0)
                                }
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        Spacer()

                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                        }
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
            
            
        }
        .sheet(isPresented: $showingSheet, onDismiss: resetCards) {
            if self.showingSettingsScreen{
                SettingsView(sendToBack: self.$sendToBack)
            }else{
                EditCards()
            }
                
            }
        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
