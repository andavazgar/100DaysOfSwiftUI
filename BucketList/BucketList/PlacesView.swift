//
//  PlacesView.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-18.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import MapKit
import SwiftUI

struct PlacesView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var showingEditScreen = false
    let filename = "SavedPlaces"
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate,selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                        
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                self.showingEditScreen = true
            })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(landmark: self.selectedPlace!)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let data = FileManager.default.loadDocument(filename) else { return }
        
        do {
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data. " + error.localizedDescription)
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(locations)
            FileManager.default.writeDocument(filename, withData: data, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data. " + error.localizedDescription)
        }
    }
}
