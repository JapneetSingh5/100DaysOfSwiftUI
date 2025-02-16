//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Japneet Singh on /158/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State var sort: [NSSortDescriptor]
    @State var predicate: String? = nil
    
    enum filter : String {
        case U = "U"
        case S = "S"
    }

    var body: some View {
                
        VStack{
            FilteredList(sort: self.sort, predicate: self.predicate)
                        
            VStack{
                            Button("Add") {
                                let candy1 = Candy(context: self.moc)
                                candy1.name = "Mars"
                                candy1.origin = Country(context: self.moc)
                                candy1.origin?.shortName = "UK"
                                candy1.origin?.fullName = "United Kingdom"

                                let candy2 = Candy(context: self.moc)
                                candy2.name = "KitKat"
                                candy2.origin = Country(context: self.moc)
                                candy2.origin?.shortName = "UK"
                                candy2.origin?.fullName = "United Kingdom"

                                let candy3 = Candy(context: self.moc)
                                candy3.name = "Twix"
                                candy3.origin = Country(context: self.moc)
                                candy3.origin?.shortName = "UK"
                                candy3.origin?.fullName = "United Kingdom"

                                let candy4 = Candy(context: self.moc)
                                candy4.name = "Toblerone"
                                candy4.origin = Country(context: self.moc)
                                candy4.origin?.shortName = "CH"
                                candy4.origin?.fullName = "Switzerland"

                                    try? self.moc.save()
                                
                            }
                        
                            Button("Sort by Country, ASC"){
                                self.sort = [NSSortDescriptor(keyPath: \Country.fullName, ascending: true)]
                            }
                
                        
                            Button("Sort by Country, DESC"){
                                self.sort = [NSSortDescriptor(keyPath: \Country.fullName, ascending: false)]
                            }
            }

                    
                        Button("Filter name, U"){
                            self.predicate = filter.U.rawValue
                        }

                        Button("Filter name, S"){
                            self.predicate = filter.S.rawValue
                        }
            
                        Button("Remove filter"){
                            self.predicate = nil
                        }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sort: [NSSortDescriptor]())
    }
}
