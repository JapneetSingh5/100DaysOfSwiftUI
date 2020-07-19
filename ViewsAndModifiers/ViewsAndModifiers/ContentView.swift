//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Japneet Singh on /207/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI


//custom Modifiers

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct CustomTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

//extending view for easier use of cutom Modifiers

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    func customTitle() -> some View {
        self.modifier(CustomTitle())
    }
}

//composed View below

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
        
    }
}

//Main ContentView

struct ContentView: View {
    var body: some View {
        Text("Hello World! \nTIL Custom Modifiers and their View Extensions").customTitle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
