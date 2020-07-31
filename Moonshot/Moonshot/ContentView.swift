//
//  ContentView.swift
//  Moonshot
//
//  Created by Japneet Singh on /287/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
   
    var body: some View {
        NavigationView{
            List(missions){mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts))
                {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height:44)
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
