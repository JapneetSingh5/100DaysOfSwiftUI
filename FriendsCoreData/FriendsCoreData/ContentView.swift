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
        Text("Hello, World!")
        .onAppear(perform: loadData)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
