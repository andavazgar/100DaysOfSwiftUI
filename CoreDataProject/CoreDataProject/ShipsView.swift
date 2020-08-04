//
//  ShipsView.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-08-02.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ShipsView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var universeFilter: String?
    
    var body: some View {
        VStack {
            FilteredList(predicate: .equal, filterKey: "universe", filterValue: universeFilter, sortDescriptors: [NSSortDescriptor(keyPath: \Ship.name, ascending: true)]) { (ship: Ship) in
                VStack(alignment: .leading) {
                    Text(ship.nameValue)
                        .font(.headline)
                    
                    Text(ship.universeValue)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            Button("Add Examples") {
                let ship1 = Ship(context: self.moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: self.moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: self.moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: self.moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? self.moc.save()
            }
            
            HStack {
                Button("Filter: Star Wars") {
                    self.universeFilter = "Star Wars"
                }
                
                Spacer()

                Button("Filter: Star Trek") {
                    self.universeFilter = "Star Trek"
                }
            }
            .padding([.horizontal], 16)
        }
        .navigationBarTitle("Ships")
    }
}

struct ShipsView_Previews: PreviewProvider {
    static var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static var previews: some View {
        ShipsView().environment(\.managedObjectContext, context)
    }
}
