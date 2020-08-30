//
//  ContentView.swift
//  InstaFilter
//
//  Created by Japneet Singh on /248/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing(){
        currentFilter.intensity = Float(self.filterIntensity)
        
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            self.image = Image(uiImage: uiImage)
        }
    }
    
    var body: some View {
        
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
        },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
        })
        
        return NavigationView{
            VStack{
                
                ZStack{
                    Rectangle()
                        .fill(image==nil ? Color.secondary : Color.black.opacity(0))
                        .cornerRadius(20)
                    if image != nil {
                        image!
                        .resizable()
                        .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .onTapGesture {
                    self.showingImagePicker.toggle()
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                    ImagePicker(image: self.$inputImage)
                }
                
                HStack{
                    Text("Intensity")
                        .foregroundColor(self.image == nil ? Color.secondary : Color.primary)
                    Slider(value: intensity, in: 0...1)
                }
                .disabled(self.image == nil)
                .padding()
                
                HStack{
                    
                    Button("Change Filter"){
                        //Change the filter
                    }
                    Spacer()
                    Button("Save Image"){
                        //Save the image
                    }
                }
            .padding()
                
                
            }
            .padding(.bottom)
            .padding(.top)
        .navigationBarTitle("InstaFilter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

