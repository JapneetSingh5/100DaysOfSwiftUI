//
//  ContentView.swift
//  Animations
//
//  Created by Japneet Singh on /237/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount : CGFloat = 1
    @State private var animationAmount2 : CGFloat = 1
    
    var body: some View {
        print(animationAmount)
        
        return VStack(spacing: 20) {
            Button("Tap Me"){
                self.animationAmount += 1
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            .blur(radius: (animationAmount - 1)*3)
 
            Button(action: {
                self.animationAmount += 1}
            ){
                Text("No, Tap Me!")
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(Color.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.red)
                .scaleEffect(animationAmount2)
                .opacity(Double(2-animationAmount2))
                )
            .animation(
                Animation.easeInOut(duration: 1)
                .repeatForever(autoreverses: false)
            ).onAppear{
            self.animationAmount2=2
            }
            
            Stepper("Scale amount", value: $animationAmount.animation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ), in: 1...10)

            Spacer()

            Button("Tap Me") {
                self.animationAmount += 1
            }
            .padding(40)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
