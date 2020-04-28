//
//  MissionView.swift
//  Moonshot
//
//  Created by Andres Vazquez on 2020-04-27.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.description)
                    .padding()
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        MissionView(mission: missions[0])
    }
}
