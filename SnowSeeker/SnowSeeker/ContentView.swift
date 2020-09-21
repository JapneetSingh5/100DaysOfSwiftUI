//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Japneet Singh on /219/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        
        NavigationView{
            Text("Secondary")
            .navigationBarTitle("Primary")
            
            Group {
                if sizeClass == .compact {
                    VStack {
                        UserView()
                    }
                } else {
                    HStack {
                        UserView()
                    }
                }
            }
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
