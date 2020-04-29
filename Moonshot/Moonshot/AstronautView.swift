//
//  AstronautView.swift
//  Moonshot
//
//  Created by Andres Vazquez on 2020-04-28.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    var astronaut: Astronaut
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
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
