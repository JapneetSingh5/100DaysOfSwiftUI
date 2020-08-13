//
//  DetailView.swift
//  Bookworm
//
//  Created by Japneet Singh on /128/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    let book: Book
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    func deleteBook() {
        moc.delete(book)

        // uncomment this line if you want to make the deletion permanent
         try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image((self.book.genre == "" ? "default" : self.book.genre)! )
                    .resizable()
                    .scaledToFit()
                        .frame(maxWidth: geometry.size.width)

                    Text((self.book.genre == "" ? "Unknown".uppercased() : self.book.genre?.uppercased())!)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text("Finished reading on \(self.book.date ?? Date(), formatter: self.dateFormatter)")
                    .padding(.top, 10)
                    .font(.subheadline)

                Text(self.book.review ?? "No review")
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)

                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .automatic)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                }, secondaryButton: .cancel()
            )
        }
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
                .foregroundColor(.red)
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return NavigationView {
            DetailView(book: book)
        }
    }
}
