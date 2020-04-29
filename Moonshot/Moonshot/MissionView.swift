//
//  MissionView.swift
//  Moonshot
//
//  Created by Andres Vazquez on 2020-04-27.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        var role: String
        var astronaut: Astronaut
    }
    
    let mission: Mission
    let crewMembers: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var crewMembersMatched = [CrewMember]()
        
        for member in mission.crew {
            if let astronaut = astronauts.first(where: { $0.id == member.name }) {
                crewMembersMatched.append(CrewMember(role: member.role, astronaut: astronaut))
            } else {
                fatalError("Missing member: \(member)")
            }
        }
        
        self.crewMembers = crewMembersMatched
    }
    
    init(mission: Mission) {
        let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
        self.init(mission: mission, astronauts: astronauts)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text("Launch Date: \(self.mission.formattedLaunchDate)")
                        .foregroundColor(.secondary)
                        .padding(.top)
                    
                    Text(self.mission.description)
                    .padding()
                    
                    ForEach(self.crewMembers, id: \.role) { member in
                        NavigationLink(destination: AstronautView(astronaut: member.astronaut)) {
                            CrewMemberView(crewMember: member)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct CrewMemberView: View {
    let crewMember: MissionView.CrewMember
    
    var body: some View {
        HStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 83, height: 60)
                .clipShape(Capsule())
                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .font(.headline)
                
                Text(crewMember.role)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        Group {
            MissionView(mission: missions[0], astronauts: astronauts)
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                MissionView(mission: missions[0], astronauts: astronauts)
                    .colorScheme(.dark)
            }
            
            CrewMemberView(crewMember: MissionView.CrewMember(role: "Commander", astronaut: astronauts[0]))
                .previewLayout(.sizeThatFits)
                .padding(.vertical)
            
            CrewMemberView(crewMember: MissionView.CrewMember(role: "Commander", astronaut: astronauts[0]))
                .previewLayout(.sizeThatFits)
                .padding(.vertical)
                .colorScheme(.dark)
                .background(Color.black)
        }
    }
}
