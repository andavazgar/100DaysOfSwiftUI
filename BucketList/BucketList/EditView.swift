//
//  EditView.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-17.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import MapKit
import SwiftUI

struct EditView: View {
    enum LoadingState {
        case loading, loaded, failed
    }
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var landmark: MKPointAnnotation
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $landmark.titleValue)
                    TextField("Description", text: $landmark.subtitleValue)
                }
                
                Section(header: Text("Nearby...")) {
                    if loadingState == .loaded {
                        List(pages, id: \.pageid) { page in
                            HStack {
                                Text(page.title + ": ")
                                    .font(.headline)
                                Text(page.description)
                                    .italic()
                            }
                        }
                    } else if loadingState == .loading {
                        Text("Loading...")
                    } else {
                        Text("Please try again later. ")
                    }
                }
            }
            .navigationBarTitle(landmark.titleValue == "" ? "Add new place" : "Edit place")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchNearbyPlaces)
        }
    }
    
    func fetchNearbyPlaces() {
        guard let url = URL(string: "https://en.wikipedia.org/w/api.php?ggscoord=\(landmark.coordinate.latitude)%7C\(landmark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json") else { return }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let result = try JSONDecoder().decode(Result.self, from: data)
                
                DispatchQueue.main.async {
                    self.loadingState = .loaded
                    self.pages = Array(result.query.pages.values).sorted()
                }
            } catch {
                print(error.localizedDescription)
                
                DispatchQueue.main.async {
                    self.loadingState = .failed
                }
            }
        }
    }
}
