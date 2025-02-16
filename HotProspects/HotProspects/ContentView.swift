//
//  ContentView.swift
//  HotProspects
//
//  Created by Japneet Singh on /149/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import UserNotifications


struct ContentView: View {
    var prospects = Prospects()
   
    var body: some View {
        TabView{
            ProspectsView(filter: .none)
                .tabItem{
                    Image(systemName: "person.3")
                    Text("Everyone")
            }
            ProspectsView(filter: .contacted)
                .tabItem{
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
            }
            ProspectsView(filter: .uncontacted)
                .tabItem{
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
            }
            MeView()
                .tabItem{
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }
        .environmentObject(self.prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
