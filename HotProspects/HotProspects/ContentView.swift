//
//  ContentView.swift
//  HotProspects
//
//  Created by Andres Vazquez on 2020-08-28.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Tab 1")
                .tabItem {
                    Image(systemName: "star")
                    Text("Tab 1")
                }
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Tab 2")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
