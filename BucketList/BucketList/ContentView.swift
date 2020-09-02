//
//  ContentView.swift
//  BucketList
//
//  Created by Japneet Singh on /19/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    let users = [
User(firstName: "Japneet", lastName: "Singh"),
User(firstName: "Jasper", lastName: "Singh")
    ].sorted()
    
    @State private var isUnlocked = false
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                
                DispatchQueue.main.async {
                    if success{
                        self.isUnlocked = true
                    }else{
                        //probs
                    }
                }
                
            }
        }else{
            //no biometrics
        }
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    var body: some View {
        VStack{
            if self.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
//            List(users){user in
//            Text("\(user.firstName) \(user.lastName)")
//        }
            MapView()
            .edgesIgnoringSafeArea(.all)
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
    .onAppear(perform: authenticate)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
