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
    @State private var blurAmount: CGFloat = 0
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    @State private var image:  Image?
    @State private var twirlAmount: Double = 0

    var body: some View {
        var twirl = Binding<Double>(
            get:{
                self.twirlAmount
            },
            set:{
                self.twirlAmount = $0
                self.loadImage()
            }
        )
        return VStack {
            image?
            .resizable()
            .scaledToFit()
            .drawingGroup()
            Slider(value: twirl, in: 0...1000)
            .padding()
        }
            
        .onAppear(perform: loadImage)
    }
    
    func loadImage(){
        
        guard let inputImage = UIImage(named: "Example") else {return}
        
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        
        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(self.twirlAmount, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width/2 , y: inputImage.size.height/2), forKey: kCIInputCenterKey)
        guard let outputImage = currentFilter.outputImage else {return}
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
