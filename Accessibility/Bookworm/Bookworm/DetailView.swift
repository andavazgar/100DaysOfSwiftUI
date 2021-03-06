//
//  DetailView.swift
//  Bookworm
//
//  Created by Andres Vazquez on 2020-07-31.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let book: Book
    var formattedReviewDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm a"
        
        return dateFormatter.string(from: book.reviewDate ?? Date())
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Unknown")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre != nil && book.genre != "Unknown" ? book.genre!.uppercased() : "UNKNOWN GENRE")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.3))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.title)
            
            Text(book.reviewDate != nil ? formattedReviewDate : "")
                .foregroundColor(.secondary)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete"), action: deleteBook), secondaryButton: .cancel())
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert.toggle()
        }) {
            Image(systemName: "trash")
        })
    }
    
    private func deleteBook() {
        moc.delete(book)
        try? moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
