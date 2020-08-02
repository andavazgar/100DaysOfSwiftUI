//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-07-31.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Movie.entity(), sortDescriptors: []) var movies: FetchedResults<Movie>
    
    var body: some View {
        VStack {
            List(movies, id: \.self) { (movie: Movie) in
                Text(movie.titleValue)
            }
            
            Button("Add") {
                let movie = Movie(context: self.moc)
                movie.title = "Titanic"
                movie.director = "James Cameron"
                movie.year = 1997
            }
            
            Button("Save") {
                if self.moc.hasChanges {
                    do {
                        try self.moc.save()
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
