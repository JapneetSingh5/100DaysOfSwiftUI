//
//  UnlockedView.swift
//  BucketList
//
//  Created by Japneet Singh on /99/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import MapKit

struct UnlockedView: View {
    @State var centerCoordinate: CLLocationCoordinate2D
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func loadData(){
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
         
        do {
            let data = try Data(contentsOf: filename)
            print("File found")
            print(data.description)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
            print("Data loaded")
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData(){
        do{
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Data saved")
        }catch{
            print("Unable to save data")
        }
    }
    
    var body: some View {
        ZStack{
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
            .edgesIgnoringSafeArea(.all)
            Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example Location"
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }){
                        Image(systemName: "plus")
                        .padding()
                         .background(Color.black.opacity(0.75))
                         .foregroundColor(.white)
                         .font(.title)
                         .clipShape(Circle())
                         .padding(.trailing)
                    }
                }
            }
        }
        .onAppear(perform: loadData)
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                self.showingEditScreen = true
            })
        }
        .sheet(isPresented: self.$showingEditScreen, onDismiss: saveData){
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
         
    }
}

struct UnlockedView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockedView(centerCoordinate: MKPointAnnotation.example.coordinate)
    }
}
