//
//  ContentView.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-04-29.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var colorCycle = 0.0
    var body: some View {
        VStack {
            ColorCyclingCircle(amount: colorCycle)
            
            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PathAndShapeView()
            FlowerView()
            ImagePaintView()
            SpirographView()
            Arrow(direction: .degrees(0))
            ContentView()
        }
    }
}
