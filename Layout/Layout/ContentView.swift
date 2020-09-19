//
//  ContentView.swift
//  Layout
//
//  Created by Japneet Singh on /199/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("testing")
                Text("testing")
                Text("testing")
                Text("testing")
                Text("testing")
                Text("testing")
                Text("testing")
                Text("testing")
                Text("@japneet")
                    .lineLimit(nil)
                .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.top] }
                Image("profile-pic")
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("testing")
                Text("testing")
                Text("testing")
                Text("testing")
                Text("testing")
                Text("Full name:")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.top] }
                Text("JAPNEET SINGH")
                    .font(.largeTitle)
                Text("testing")
                Text("testing")
                Text("testing")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
