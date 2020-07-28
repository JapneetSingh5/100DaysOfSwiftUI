//
//  ContentView.swift
//  Moonshot
//
//  Created by Japneet Singh on /287/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView: View {
    @State private var user: User = User(name: "ABC", address: Address(street: "Street", city: "Delhi maybe"))
    var body: some View {
        VStack {
            Text("\(user.name)")
            Button("Decode JSON") {
                let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashville"
                    }
                }
                """

               let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(User.self, from: data) {
                    print(user)
                    self.user = user
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
