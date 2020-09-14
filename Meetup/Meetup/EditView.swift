//
//  DetailView.swift
//  Meetup
//
//  Created by Japneet Singh on /149/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import MapKit

struct EditView: View {
    let locationFetcher = LocationFetcher()
    @State private var image = UIImage(imageLiteralResourceName: "default")
    @State private var confName = ""
    @State private var confDate = Date()
    @State private var personName: String = ""
    @State private var personCompany: String = ""
    @State private var showingImagePicker = false
    @State private var coordinate: CLLocationCoordinate2D?
    @State var imageEdit: ImageData
    @State private var locationButton = "Add current location"
    @ObservedObject var imageList: Images
    @Environment(\.presentationMode) var presentationMode
    
    func addImage(){
        if let index = imageList.images.firstIndex(of: imageEdit){
            imageList.images.remove(at: index)
        }
        imageList.images.append(ImageData(image: self.image, personName: self.personName, personCompany: self.personCompany, meetup: self.confName, date: self.confDate, latitude: self.coordinate?.latitude ?? example.latitude, longitude: self.coordinate?.longitude ?? example.longitude ))
        presentationMode.wrappedValue.dismiss()
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func saveData(){
        do{
            let filename = getDocumentsDirectory().appendingPathComponent("SavedImages")
            let data = try JSONEncoder().encode(self.imageList.images)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Data saved")
        }catch{
            print("Unable to save data")
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
                    .onTapGesture {
                            self.showingImagePicker = true
                    }
                }
                Section(header: Text("PERSON DETAILS")){
                    TextField("Full Name", text: self.$personName)
                    TextField("Company", text: self.$personCompany)
                }
                Section(header: Text("MEETUP DETAILS")){
                    TextField("Meetup Name", text: self.$confName)
                    DatePicker(selection: self.$confDate, displayedComponents: .date){
                        Text("Meetup Date")
                    }
                    HStack{
                        Text("Location")
                            .padding(.leading)
                        Spacer()
                        Button("\(locationButton)"){
                            self.locationFetcher.start()
                            if let location = self.locationFetcher.lastKnownLocation {
                                self.coordinate = location
                                print("Your location is \(location)")
                                self.locationButton = "\(location)"
                            } else {
                                print("Your location is unknown")
                                self.locationButton = "Location Unknown"
                            }
                        }
                    }
                    
                }
                Section{
                    Button("Save"){
                        self.addImage()
                        self.saveData()
                    }
                }
            }
            .sheet(isPresented: self.$showingImagePicker){
                ImagePicker(image: self.$image, sourceType: UIImagePickerController.SourceType.photoLibrary)
            }
            .navigationBarTitle("Edit Meetup Image")
            .navigationBarItems(trailing: Button("Cancel"){
                self.saveData()
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(imageEdit: ImageData(), imageList: Images())
    }
}
