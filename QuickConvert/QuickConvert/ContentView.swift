//
//  ContentView.swift
//  QuickConvert
//
//  Created by Japneet Singh on /177/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputUnit = 0
    @State private var outputUnit = 1
    @State private var inputQuantity = ""
    
    let availableUnits = ["milliliters", "liters","cups", "pints", "gallons" ]
    
    var processedInput: Double{
        let value = Double(inputQuantity) ?? 0
        switch inputUnit {
        case 0:
            return value
        case 1:
            return value*1000
        case 2:
            return value*284.1309735446
        case 3:
            return value*473.1764559425976
        case 4:
            return value*3785.399647541898
        default:
            return 0
        }
    }
    
    var output: Double{
        let value = processedInput
        switch outputUnit {
        case 0:
            return value
        case 1:
            return value/1000
        case 2:
            return value/284.1309735446
        case 3:
            return value/473.1764559425976
        case 4:
            return value/3785.399647541898
        default:
            return 0
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                
                Section{
                    TextField("Input Quantity", text: $inputQuantity)
                        .keyboardType(.decimalPad)
                    Picker("Input Unit", selection: $inputUnit){
                        ForEach(0..<availableUnits.count){
                            Text("\(self.availableUnits[$0])")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Convert to:")){
                        Picker("Output Unit", selection: $outputUnit){
                            ForEach(0..<availableUnits.count){
                                Text("\(self.availableUnits[$0])")
                            }
                        }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted quantity:")){
                    Text("\(output, specifier: "%.2f") \(availableUnits[outputUnit])")
                }

            }
        .navigationBarTitle("QuickConvert")
        }


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
