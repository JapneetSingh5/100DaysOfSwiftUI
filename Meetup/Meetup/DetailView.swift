//
//  DetailView.swift
//  Meetup
//
//  Created by Japneet Singh on /149/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @State var image: ImageData
    @State var showingEditView = false
    @ObservedObject var imageList: Images
    
    var body: some View {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let date = formatter.string(from: image.date)
        
        return Group{
            MapView(image: self.image)
                .frame(maxWidth: .infinity, maxHeight: 100)
            VStack(alignment: .leading){
                HStack{
                    VStack(alignment: .leading){
                        Text(image.personName)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.leading)
                        Text(image.personCompany)
                            .padding(.leading)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text(image.meetup)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.trailing)
                        Text("\(date)")
                            .padding(.trailing)
                    }
                }
                HStack{
                    Spacer()
                    Image(uiImage: image.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding()
                    Spacer()
                }
                
                Spacer()
            }
            .navigationBarTitle("Meetup", displayMode: .inline)
            .navigationBarItems(trailing: Button("Edit"){
                self.showingEditView = true
            })
                .sheet(isPresented: self.$showingEditView){
                    EditView(imageEdit: self.image, imageList: self.imageList)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(image: ImageData(), imageList: Images())
    }
}
