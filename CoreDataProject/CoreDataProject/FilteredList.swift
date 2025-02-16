//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Japneet Singh on /178/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Country>
    
    init(sort: [NSSortDescriptor], predicate: String?) {
        fetchRequest = FetchRequest<Country>(entity: Country.entity(), sortDescriptors: sort, predicate: predicate == nil ? nil : NSPredicate(format: "\(#keyPath(Country.fullName)) BEGINSWITH %@", predicate!))
    }
    
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { country in
            Section{
                VStack{
                    Text("\(country.wrappedFullName)").font(.largeTitle)
                    
                    ForEach(country.candyArray, id:\.self){candy in
                        Text("\(candy.wrappedName)")
                    }
                }

            }

           }
    }
}

struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList(sort: [NSSortDescriptor](), predicate: "U")
    }
}
