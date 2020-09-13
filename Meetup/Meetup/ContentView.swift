//
//  ContentView.swift
//  Meetup
//
//  Created by Japneet Singh on /139/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var 
    var body: some View {
        VStack{
            Image(uiImage: self.image)
            .resizable()
            .scaledToFit()
            Button("Select an image"){
                self.showImagePicker = true
            }
            .sheet(isPresented: self.$showImagePicker){
                ImagePicker(image: self.$image)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
