//
//  ContentView.swift
//  FriendsCoreData
//
//  Created by Japneet Singh on /228/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(entity: User.entity(), sortDescriptors: [], predicate: nil) var users: FetchedResults<User>
    @Environment(\.managedObjectContext) var moc
    @State private var tempUsers = [TempUser]()
    
    func loadData(){
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                do{
                    let decodedResponse = try JSONDecoder().decode([TempUser].self, from: data)
                        // we have good data – go back to the main thread
                        DispatchQueue.main.async {
                            // update our UI
                            self.tempUsers = decodedResponse.self
                            for user in self.tempUsers {
                                let createUser = User(context: self.moc)
                                createUser.id = user.id
                                createUser.isActive = user.isActive
                                createUser.name = user.name
                                createUser.age = Int16(user.age)
                                createUser.company = user.company
                                createUser.email = user.email
                                createUser.address = user.address
                                createUser.about = user.about
                                createUser.registered = user.registered
                                
                                for tag in user.tags{
                                    let createTag = Tag(context: self.moc)
                                    createTag.tag = tag
                                    createUser.userTags?.adding(createTag)
                                }
                                
                                for friend in user.friends{
                                    let createFriend = Friend(context: self.moc)
                                    createFriend.name = friend.name
                                    createFriend.id = friend.id
                                    createUser.friends?.adding(createFriend)
                                }
                            }
                            
                            if self.moc.hasChanges{
                                try? self.moc.save()
                            }
                            
                            print(self.tempUsers[0])
                        }
                }
                catch{
                    print("Fetch failed: \(error.localizedDescription )")
                }
                
            }
            
        }.resume()
    }
    
    var body: some View {
        List(users, id:\.self.id){ user in
            Text(user.wrappedName)
        }
        .onAppear(perform: loadData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
