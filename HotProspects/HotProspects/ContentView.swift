//
//  ContentView.swift
//  HotProspects
//
//  Created by Andres Vazquez on 2020-08-28.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        TabView {
            Text("Tab 1")
                .background(backgroundColor)
                .tabItem {
                    Image(systemName: "star")
                    Text("Tab 1")
                }
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        Image(systemName: "1.circle")
                    }

                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                        Image(systemName: "2.circle")
                    }

                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                        Image(systemName: "3.circle")
                    }
                }
                .onTapGesture {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            let content = UNMutableNotificationContent()
                            content.title = "Feed the cat"
                            content.subtitle = "It looks hungry"
                            content.sound = UNNotificationSound.default
                            
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                            UNUserNotificationCenter.current().add(request)
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
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
