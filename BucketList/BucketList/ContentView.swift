//
//  ContentView.swift
//  BucketList
//
//  Created by Japneet Singh on /19/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentView: View {
    
    @State private var isUnlocked = false
    @State private var showingAuthAlert = false
    @State var centerCoordinate: CLLocationCoordinate2D
    
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
                        
                    }
                }
                
            }
        }else{
            self.showingAuthAlert = true
            
        }
    }
    
    var body: some View {
        ZStack{
            if isUnlocked{
                UnlockedView(centerCoordinate: self.centerCoordinate)
            }
            else{
                Group{
                    Button("Unlock Places") {
                        self.authenticate()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .alert(isPresented: $showingAuthAlert){
                    Alert(title: Text("Authentication Failed"), message: Text("No authentication method found"), dismissButton: .default(Text("OK")))
                }

            }

        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(centerCoordinate: MKPointAnnotation.example.coordinate)
    }
}
