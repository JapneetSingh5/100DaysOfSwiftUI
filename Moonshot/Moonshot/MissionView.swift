//
//  MissionView.swift
//  Moonshot
//
//  Created by Japneet Singh on /307/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                VStack{
                    Image(decorative: self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    Text("Launched: \(self.mission.formattedLaunchDate)").font(.headline).padding(.top)
                    Text("\(self.mission.description)")
                        .padding()
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)){
                            HStack {
                                    Image(crewMember.astronaut.id)
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: geometry.size.width)
                                        .overlay(
                                            AstronautOverlay(crewMember: crewMember))
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        .padding(.bottom, 10)
                                    Spacer()
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(crewMember.role) : \(crewMember.astronaut.name)"))
                            
                            .padding(.horizontal)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }.navigationBarTitle("\(self.mission.displayName)")
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}

struct AstronautOverlay: View {
    let crewMember:  MissionView.CrewMember
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            VStack{
                Text(crewMember.astronaut.name)
                    .font(.headline)
                    .foregroundColor(Color.white)
                Text(crewMember.role)
                    .foregroundColor(Color.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.6))
        }
    }
}
