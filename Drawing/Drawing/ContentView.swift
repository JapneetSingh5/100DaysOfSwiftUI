//
//  ContentView.swift
//  Drawing
//
//  Created by Japneet Singh on /18/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY), radius: rect.width/2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)

        return path
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    let rotationAdjustment = Angle.degrees(90)
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        let modifiedStart = startAngle
        let modifiedEnd = endAngle - endAngle - endAngle
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)

        return path
    }
}

struct ContentView: View {
    var body: some View {
        VStack{
            Triangle()
            .frame(width: 200, height: 200)
                .foregroundColor(.red)
            Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .stroke(Color.blue, lineWidth: 10)
            .frame(width: 300, height: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
