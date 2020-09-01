//
//  ContentView.swift
//  BucketList
//
//  Created by Japneet Singh on /19/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let users = [
User(firstName: "Japneet", lastName: "Singh"),
User(firstName: "Jasper", lastName: "Singh")
    ].sorted()
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    var body: some View {
        VStack{
            List(users){user in
            Text("\(user.firstName) \(user.lastName)")
        }
            Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = self.getDocumentsDirectory().appendingPathComponent("message.txt")

                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
