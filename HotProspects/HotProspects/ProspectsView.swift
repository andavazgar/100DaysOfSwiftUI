//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Andres Vazquez on 2020-09-01.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.email)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(trailing: Button(action: {
                let prospect = Prospect()
                prospect.name = "Andres"
                prospect.email = "andres@email.com"
                
                self.prospects.people.append(prospect)
            }) {
                Image(systemName: "qrcode.viewfinder")
                Text("Scan")
            })
        }
        
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
