//
//  ContentView.swift
//  Bookworm
//
//  Created by Japneet Singh on /98/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI





struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]

            // delete it from the context
            moc.delete(book)
        }

        // save the context
        try? moc.save()
    }

        var body: some View {
           NavigationView {
                List {
                    ForEach(books, id: \.self) { book in
                        NavigationLink(destination: DetailView(book: book)) {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)

                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating < 2 ? .red : .primary)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: deleteBooks)
                }
                    .navigationBarTitle("Bookworm")
                    .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                        self.showingAddScreen.toggle()
                    }) {
                        Image(systemName: "plus")
                            .accessibility(hint: Text("Add a new book"))
                            .accessibility(label: Text("Add"))
                            .accessibility(removeTraits: .isImage)
                    })
                    .sheet(isPresented: $showingAddScreen) {
                        AddBookView().environment(\.managedObjectContext, self.moc)
                    }
            }
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
