//
//  ContentView.swift
//  Animations
//
//  Created by Japneet Singh on /237/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
         Button("Tap Me") {
            withAnimation(Animation.interpolatingSpring(stiffness: 5, damping: 10)
                .repeatCount(3, autoreverses: true)) {
                       self.animationAmount += 360
                   }
               }
               .padding(50)
               .background(Color.red)
               .foregroundColor(.white)
               .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
