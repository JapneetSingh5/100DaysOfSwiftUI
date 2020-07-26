//
//  ContentView.swift
//  iExpense
//
//  Created by Japneet Singh on /267/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Second View")
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct NestedView: View{
    @ObservedObject var user2: User
    
    var body: some View{
        VStack {
            Text("Your name is \(user2.firstName) \(user2.lastName).")

            TextField("First name", text: $user2.firstName)
            TextField("Last name", text: $user2.lastName)
        }
    }

}

struct ContentView: View {
    @ObservedObject var user = User()
    @State private var showingSheet = false

    var body: some View {
        VStack {
            NestedView(user2: user)
            Button("Show Sheet") {
                self.showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
