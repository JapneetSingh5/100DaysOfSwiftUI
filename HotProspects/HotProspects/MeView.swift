//
//  MeView.swift
//  HotProspects
//
//  Created by Japneet Singh on /169/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    static let saveKey = "MeData"
    
    @State var name = "Anonymous"
    @State var emailAddress = "you@yoursite.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func saveMeData() {
        do{
            let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
            let data = try JSONEncoder().encode(self.name + "\n" + self.emailAddress)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("MeData saved")
        }catch{
            print("Unable to save MeData")
        }
    }
    
    
    func loadMeData(){
        let filename = getDocumentsDirectory().appendingPathComponent(Self.saveKey)
         
        do {
            let data = try Data(contentsOf: filename)
            print("File found")
            print(data.description)
            let me = try JSONDecoder().decode(String.self, from: data)
            let temp = me.components(separatedBy: "\n")
            self.name = temp[0]
            self.emailAddress = temp[1]
            print("MeData loaded")
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    var body: some View {
        let name = Binding<String> (
            get: {
                self.name
            },
            set: {
                self.name = $0
                self.saveMeData()
            }
        )
        let emailAddress = Binding<String> (
            get: {
                self.emailAddress
            },
            set: {
                self.emailAddress = $0
                self.saveMeData()
            }
        )
        return NavigationView {
            VStack {
                TextField("Name", text: name)
                    .textContentType(.name)
                    .font(.largeTitle)
                    .padding(.horizontal)

                TextField("Email address", text: emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])

                Spacer()
                Image(uiImage: generateQRCode(from: "\(self.name)\n\(self.emailAddress)"))
                    .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                Spacer()
            }
            .onAppear(perform: loadMeData)
            .navigationBarTitle("Your code")
        }
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
