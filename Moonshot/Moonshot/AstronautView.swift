//
//  AstronautView.swift
//  Moonshot
//
//  Created by Japneet Singh on /307/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct MissionDone: Identifiable {
    let id: Int
    let role: String
}

struct AstronautView: View {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let astronaut: Astronaut
    
    var missionsDone = [MissionDone]()
    
    init(astronaut: Astronaut){
        for mission in AstronautView.missions {
            if let match = mission.crew.first(where: { $0.name == astronaut.id }) {
                missionsDone.append(MissionDone(id: mission.id, role: match.role))
            }
        }
        self.astronaut = astronaut
    }
    
    var body: some View {
        GeometryReader { geometry in
                    ScrollView(.vertical) {
                        VStack {
                            Image(self.astronaut.id)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width*0.9)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding()
                            Text(self.astronaut.description)
                            .padding()
                            .layoutPriority(1)
                            HStack {
                                Text("Missions").font(.headline).fontWeight(.semibold).padding(.top, 10).padding(.leading, 10)
                                Spacer()
                            }
                            ForEach(self.missionsDone){mission in
                                NavigationLink(destination: MissionView(mission: AstronautView.missions.filter{ $0.id == mission.id}[0], astronauts: AstronautView.astronauts)){
                                    HStack {
                                        Image("apollo\(mission.id)")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height:44)
                                        VStack(alignment: .leading){
                                            Text("Apollo \(mission.id)")
                                            Text("\(mission.role)").foregroundColor(.secondary)
                                        }
                                        Spacer()
                                    }
                                }.buttonStyle(PlainButtonStyle())
                            }.padding(.leading, 10)
                            }
                        }
                    }
            .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
            }
    }


struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[10])
    }
}
