//
//  ContentView.swift
//  InstaFilter
//
//  Created by Japneet Singh on /248/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white

    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
        },
            set: {
                self.blurAmount = $0
                print("Blur amount is now \($0)")
        })
        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
                .frame(width: 300, height: 300)
                .background(self.backgroundColor)
                .onTapGesture {
                    self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet){
                ActionSheet(title: Text("Change Background"), message: Text("Select a color"), buttons: [
                    .default(Text("Red"), action: {
                        self.backgroundColor = Color.red
                    }),
                    .default(Text("Blue"), action: {
                        self.backgroundColor = Color.blue
                    }),
                    .default(Text("Green"), action: {
                        self.backgroundColor = Color.green
                    }),
                    .cancel(),
                    .destructive(Text("Cancel")){
                        print("Destructive Cancel")
                    }
                ])
            }
            

            Slider(value: blur, in: 0...20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
