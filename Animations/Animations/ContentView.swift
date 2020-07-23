//
//  ContentView.swift
//  Animations
//
//  Created by Japneet Singh on /237/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    @State private var dragAmount2 = CGSize.zero
    let letters = Array("Hello World!")
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded {_ in
                            withAnimation(Animation.spring(response: 1, dampingFraction: 0.5, blendDuration: 0))
                                {
                                  self.dragAmount = .zero
                                }
                        }
            )
            
            HStack(spacing: 0) {
                ForEach(0..<letters.count) { num in
                    Text(String(self.letters[num]))
                        .padding(5)
                        .font(.title)
                        .background(self.enabled ? Color.blue : Color.red)
                        .offset(self.dragAmount2)
                        .animation(Animation.default.delay(Double(num) / 20))
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount2 = $0.translation }
                    .onEnded { _ in
                        self.dragAmount2 = .zero
                        self.enabled.toggle()
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
