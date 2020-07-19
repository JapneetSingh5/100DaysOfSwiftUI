//
//  ContentView.swift
//  WeSplit
//
//  Created by Japneet Singh on 16/7/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

//struct Warning: ViewModifier{
//    func body(content: Content) -> some View {
//        content.foregroundColor(.red)
//    }
//}
//
//extension View{
//    func warning() -> some View{
//        self.modifier(Warning())
//    }
//}

struct ContentView: View {
    @State var checkAmount = ""
    @State var numberOfPeople = ""
    @State var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var grandTotal : Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue

        return grandTotal
    }
    
    var totalPerPerson : Double {
        let initPeopleCount = Double(numberOfPeople) ?? 0
        let peopleCount = initPeopleCount + 2
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            
            Form {
                
                Section{
                    
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
//                    Picker("Number Of People", selection: $numberOfPeople){
//                        ForEach(2..<100){
//                            Text("\($0) People")
//                        }
//                    }
                    TextField("Number Of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Grand total")){
                    Text("$\(grandTotal, specifier: "%.2f")").foregroundColor(tipPercentage == 4 ? .red : .primary)
                }
                
                Section(header: Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }

            }
        .navigationBarTitle("WeSplit")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
