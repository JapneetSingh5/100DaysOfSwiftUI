//
//  AddBookView.swift
//  Bookworm
//
//  Created by Japneet Singh on /118/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var date = Date()
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
                    
                    DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                        Text("Date completed")
                    }
                }

                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }

                Section {
                    Button("Save") {
                        let newBook = Book(context: self.moc)
                        newBook.title = self.title
                        newBook.author = self.author
                        newBook.rating = Int16(self.rating)
                        newBook.genre = self.genre
                        newBook.review = self.review
                        newBook.date = self.date

                        try? self.moc.save()
                        
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
