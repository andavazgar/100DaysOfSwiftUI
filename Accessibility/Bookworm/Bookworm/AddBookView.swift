//
//  AddBookView.swift
//  Bookworm
//
//  Created by Andres Vazquez on 2020-07-30.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var rating = 3
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        let book = Book(context: self.moc)
                        book.id = UUID()
                        book.title = self.title
                        book.author = self.author
                        book.rating = Int16(self.rating)
                        book.genre = !self.genre.isEmpty ? self.genre : "Unknown"
                        book.review = self.review
                        book.reviewDate = Date()
                        
                        do {
                            try self.moc.save()
                        } catch {
                            print(error)
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
