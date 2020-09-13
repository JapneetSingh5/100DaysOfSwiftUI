//
//  AddImage.swift
//  Meetup
//
//  Created by Japneet Singh on /139/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct AddImage: View {
    @State private var image = UIImage(imageLiteralResourceName: "default")
    @State private var confName = ""
    @State private var confDate = Date()
    @State private var personName: String = ""
    @State private var personCompany: String = ""
    var body: some View {
            Form{
                Section{
                    Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
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
                }
            }
    .navigationBarTitle("Add Meetup Image")
        }
}

struct AddImage_Previews: PreviewProvider {
    static var previews: some View {
        AddImage()
    }
}
