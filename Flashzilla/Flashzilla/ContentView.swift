//
//  ContentView.swift
//  Flashzilla
//
//  Created by Andres Vazquez on 2020-09-30.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onReceive(timer, perform: { time in
                    if self.counter < 5 {
                        print(time)
                    } else {
                        self.timer.upstream.connect().cancel()
                    }
                    
                    counter += 1
                })
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                    print("Moving to the background!")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
