//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-07-31.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CandyCountryView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, context)
    }
}
