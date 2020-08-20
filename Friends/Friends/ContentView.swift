//
//  ContentView.swift
//  Friends
//
//  Created by Japneet Singh on /208/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var users: [User]
    
    func loadData(){
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                do{
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                        // we have good data – go back to the main thread
                        DispatchQueue.main.async {
                            // update our UI
                            self.users = decodedResponse.self
                        }
                }
                catch{
                    print("Fetch failed: \(error.localizedDescription )")
                }
                
            }
            
        }.resume()
    }
    
    var body: some View {
        NavigationView{
                List(users){user in
                    NavigationLink(destination: Text("\(user.name)")){
                        HStack{
                            Circle()
                                .frame(width: 15, height: 15, alignment: .center)
                                .foregroundColor(user.isActive ? .green : .red)
                        }
                        VStack(alignment: .leading){
                            HStack{
                                Text("\(user.name)").fontWeight(.medium)
                                Text("\(user.age)").fontWeight(.light).font(.subheadline)
                            }
                            Text("\(user.friends.count) Friends")
                        }
                    }
                }
            .onAppear(perform: loadData)
        .navigationBarTitle("Friends")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(users: [User]())
    }
}
