//
//  DetailView.swift
//  FriendsCoreData
//
//  Created by Japneet Singh on /238/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    var user: User
    
    var body: some View {
        Text("\(user.wrappedName)")
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        DetailView(user: User(context: self.moc))
    }
}
