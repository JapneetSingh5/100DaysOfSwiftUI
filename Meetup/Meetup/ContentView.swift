//
//  ContentView.swift
//  Meetup
//
//  Created by Japneet Singh on /139/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var imageList = Images()
    @State private var showingAddView = false
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func loadData(){
        let filename = getDocumentsDirectory().appendingPathComponent("SavedImages")
         
        do {
            let data = try Data(contentsOf: filename)
            print("File found")
            print(data.description)
            imageList.images = try JSONDecoder().decode([ImageData].self, from: data)
            print("Data loaded")
        } catch {
            print("Unable to load saved data.")
        }
    }

    var body: some View {
        NavigationView{
            List(imageList.images.sorted()){image in
                NavigationLink(destination: Text(image.personName)){
                    HStack{
                        Image(uiImage: image.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 50)
                            .cornerRadius(4)
                        VStack(alignment: .leading){
                            Text(image.personName.uppercased())
                                .font(.headline)
                            Text(image.personCompany)
                                .font(.subheadline)
                            HStack{
                                Text(image.meetup)
                                    .font(.caption)
                                Spacer()
                            }
                        }
                    }
                }
            }
        .onAppear(perform: loadData)
        .navigationBarTitle("Meetup")
        .navigationBarItems(trailing: Button("Add Image"){
                self.showingAddView = true
            })
        }
        .sheet(isPresented: self.$showingAddView){
                AddImage(imageList: self.imageList)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
