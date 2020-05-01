//
//  ContentView.swift
//  Drawing
//
//  Created by Andres Vazquez on 2020-04-29.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        FlowerView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PathAndShapeView()
            ContentView()
        }
    }
}
