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
    @State private var filterIntensity: Double = 0.5
    @State private var filterRadius: Double = 200
    @State private var filterScale: Double = 10
    @State private var showIntensity = false
    @State private var showScale = false
    @State private var showRadius = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showingFilterSheet = false
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    @State private var currentFilterName: String = "Sepia"
    @State private var processedImage: UIImage?
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    let context = CIContext()
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing(){
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            self.showIntensity = true
        }else{
            self.showIntensity = false
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterRadius, forKey: kCIInputRadiusKey)
            self.showRadius = true
        }else{
            self.showRadius = false
        }
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(filterScale, forKey: kCIInputScaleKey)
            self.showScale = true
        }else{
            self.showScale = false
        }
        
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            self.image = Image(uiImage: uiImage)
            self.processedImage = uiImage
        }
    }
    
    func setFilter( filter: CIFilter){
        currentFilter = filter
        loadImage()
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
        let radius = Binding<Double>(
            get: {
                self.filterRadius
        },
            set: {
                self.filterRadius = $0
                self.applyProcessing()
        })
        let scale = Binding<Double>(
            get: {
                self.filterScale
        },
            set: {
                self.filterScale = $0
                self.applyProcessing()
        })
        
        return NavigationView{
            VStack(alignment: .leading){
                
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
                .padding(.horizontal)
                .padding(.bottom)
                .onTapGesture {
                    self.showingImagePicker.toggle()
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                    ImagePicker(image: self.$inputImage)
                }
                .actionSheet(isPresented: $showingFilterSheet){
                    ActionSheet(title: Text("Choose Filter"), message: Text("Choose one of the below filters to apply it on your image"), buttons: [
                        .default(Text("Sepia"), action: {self.setFilter(filter: CIFilter.sepiaTone())}),
                        .default(Text("Crystallize"), action: {
                            self.setFilter(filter: CIFilter.crystallize())
                            self.currentFilterName = "Crystallize"
                        }),
                        .default(Text("Edges"), action: {
                            self.setFilter(filter: CIFilter.edges())
                            self.currentFilterName = "Edges"
                        }),
                        .default(Text("Gaussian Blur"), action: {
                            self.setFilter(filter: CIFilter.gaussianBlur())
                            self.currentFilterName = "Gaussian Blur"
                        }),
                        .default(Text("Pixellate"), action: {
                            self.setFilter(filter: CIFilter.pixellate())
                            self.currentFilterName = "Pixellate"
                        }),
                        .default(Text("Unsharp Mask"), action: {
                            self.setFilter(filter: CIFilter.unsharpMask())
                            self.currentFilterName = "Unsharp Mask"
                        }),
                        .default(Text("Vignette"), action: {
                            self.setFilter(filter: CIFilter.vignette())
                            self.currentFilterName = "Vignette"
                        }),
                        .default(Text("Bokeh Blur"), action: {
                            self.setFilter(filter: CIFilter.bokehBlur())
                            self.currentFilterName = "Bokeh Blur"
                        }),
                        .cancel()
                    ])
                }
                .alert(isPresented: $showAlert){
                    Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("Okay")))
                }
                
                if showIntensity {
                    HStack{
                    Text("Intensity")
                        .foregroundColor(self.image == nil ? Color.secondary : Color.primary)
                    Spacer()
                        HStack{
                            Slider(value: intensity, in: 0...1)
                        }
                    .frame(width: 300)
                    
                    }
                    .disabled(self.image == nil)
                    .padding()
                }
                if showRadius{
                    HStack{
                        Text("Radius")
                            .foregroundColor(self.image == nil ? Color.secondary : Color.primary)
                        Spacer()
                        HStack{
                            Slider(value: radius, in: 10...1000)
                        }
                    .frame(width: 300)
                    }
                    .disabled(self.image == nil)
                    .padding()
                }
                if showScale{
                    HStack{
                        Text("Scale")
                            .foregroundColor(self.image == nil ? Color.secondary : Color.primary)
                        Spacer()
                        HStack{
                            Slider(value: scale, in: 1...10)
                        }
                        .frame(width: 300)
                    }
                    .disabled(self.image == nil)
                    .padding()
                }
                
                HStack{
                    
                    Button(self.image == nil ? "Show Filters" : "\(self.currentFilterName)"){
                        self.showingFilterSheet.toggle()
                    }
                    Spacer()
                    Button("Save Image"){
                        guard let processedImage = self.processedImage else {
                            self.alertTitle = "No image to save"
                            self.alertMessage = "You must select an image from the library before attempting to save it"
                            self.showAlert.toggle()
                            return
                        }
                        
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Image successfully saved to Photos!")
                            self.alertTitle = "Success"
                            self.alertMessage = "Image saved to photos successfully!"
                            self.showAlert.toggle()
                        }
                        imageSaver.errorHandler = { error in
                            print("Error: \(error.localizedDescription)")
                            self.alertTitle = "Error"
                            self.alertMessage = "Could not save image to photos. Try again late or report the issue to the developer if it persisits."
                            self.showAlert.toggle()
                        }
                        imageSaver.writeToPhotoAlbums(image: processedImage)
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

