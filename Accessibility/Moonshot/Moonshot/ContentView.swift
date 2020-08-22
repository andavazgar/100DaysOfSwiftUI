//
//  ContentView.swift
//  Moonshot
//
//  Created by Andres Vazquez on 2020-04-26.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showLaunchDates = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)

                        Text(self.rowSubtitle(mission: mission))
                            .foregroundColor(.secondary)
                            .accessibility(label: Text((self.showLaunchDates ? "\nLaunch Date: " : "\nCrew Members: ") + self.rowSubtitle(mission: mission)))
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: {
                self.showLaunchDates.toggle()
            }, label: {
                Text(showLaunchDates ? "Crew Members" :  "Launch Dates")
            }))
        }
    }
    
    private func rowSubtitle(mission: Mission) -> String {
        if showLaunchDates {
            return mission.formattedLaunchDate
        } else {
            let crewMembers = mission.crew.map { $0.name }
            let crewInfo = crewMembers.compactMap { member in astronauts.first(where: { $0.id == member })}
            return crewInfo.map { $0.name }.joined(separator: ", ")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .colorScheme(.dark)
        }
    }
}
