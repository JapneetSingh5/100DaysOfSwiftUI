//
//  ContentView.swift
//  HotProspects
//
//  Created by Japneet Singh on /149/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    @State private var selectedTab = 0
    let user = User()
    
    var body: some View {
        TabView(selection: self.$selectedTab){
            Text("Tab 1")
            .onTapGesture {
                self.selectedTab = 2
            }
            .tabItem {
                Image(systemName: "star")
                Text("One")
            }
            .tag(1)

            Text("Tab 2")
                .onTapGesture {
                    self.selectedTab = 1
            }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
        .tag(2)
        }
//       VStack {
//            EditView().environmentObject(user)
//            DisplayView().environmentObject(user)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
