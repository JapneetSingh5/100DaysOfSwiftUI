//
//  DiceView.swift
//  Roll
//
//  Created by Japneet Singh on /219/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct DiceView: View {
    
    @Binding var numberShown: Int
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color.white)
            .frame(width: 200, height: 200, alignment: .center)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            .overlay(numberShown == 0 ? Text("Ready To Roll") : Text("\(numberShown)")
                .font(.largeTitle)
                .fontWeight(.black)
                )
    }
}

struct DiceView_Previews: PreviewProvider {
    static var previews: some View {
        DiceView(numberShown: .constant(10))
    }
}
