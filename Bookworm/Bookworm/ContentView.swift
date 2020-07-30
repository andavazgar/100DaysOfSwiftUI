//
//  ContentView.swift
//  Bookworm
//
//  Created by Andres Vazquez on 2020-07-29.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var name;
    
    
    var body: some View {
        CoreDataView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BindingView()
            SizeClassView()
            ContentView()
        }
    }
}
