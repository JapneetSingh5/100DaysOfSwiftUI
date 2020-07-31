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
    
    @State private var showCrew = UserDefaults.standard.bool(forKey: "showCrew")
   
    var body: some View {
        NavigationView{
            List(missions){mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts))
                {
                    HStack {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height:44)
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                            if(!self.showCrew){
                                Text(mission.formattedLaunchDate)
                            }
                            if(self.showCrew){
                                ForEach(MissionView(mission: mission, astronauts: self.astronauts).astronauts, id: \.astronaut.id){astronautData in
                                    return VStack(alignment: .leading){
                                        Text("\(astronautData.astronaut.name)")
                                        Text("\(astronautData.role)").foregroundColor(.secondary).font(.subheadline)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
        .navigationBarItems(trailing:
            Button(!showCrew ? "Crew Details" : "Launch Dates"){
                self.showCrew.toggle()
                UserDefaults.standard.set(self.showCrew, forKey: "showCrew")
        })

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
