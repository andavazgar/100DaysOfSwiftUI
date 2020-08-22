//
//  AstronautView.swift
//  Moonshot
//
//  Created by Andres Vazquez on 2020-04-28.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        var missionsMatched = [Mission]()
        
        for mission in allMissions {
            for crewMember in mission.crew {
                if crewMember.name == astronaut.id {
                    missionsMatched.append(mission)
                }
            }
        }
        
        self.missions = missionsMatched
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(decorative: self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    HStack {
                        ForEach(self.missions) { mission in
                            NavigationLink(destination: MissionView(mission: mission)) {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        Group {
            NavigationView {
                AstronautView(astronaut: astronauts[0])
            }
            
            NavigationView {
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    
                    AstronautView(astronaut: astronauts[0])
                        .colorScheme(.dark)
                }
            }
        }
    }
}
