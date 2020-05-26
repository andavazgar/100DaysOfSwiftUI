//
//  SongsView.swift
//  CupcakeCorner
//
//  Created by Andres Vazquez on 2020-05-26.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct Response: Codable {
    var results = [Result]()
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct SongsView: View {
    @State private var results = [Result]()
    
    var body: some View {
        NavigationView {
            List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    
                    Text(item.collectionName)
                }
            }
            .navigationBarTitle("Songs")
            .onAppear(perform: loadData)
        }
    }
    
    private func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Error loading songs")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    
                    return
                }
            }
            
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct SongsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView()
    }
}
