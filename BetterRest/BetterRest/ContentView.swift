//
//  ContentView.swift
//  BetterRest
//
//  Created by Japneet Singh on /217/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct SectionTitle: ViewModifier {
    func body(content: Content) -> some View{
        content.font(.headline).foregroundColor(.primary)
    }
}

extension View {
    func sectionTitle() -> some View{
        self.modifier(SectionTitle())
    }
}

struct ContentView: View {
    
    @State private var wakeUp = ContentView.defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    static var defaultWakeUpTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var bedTime: String {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do{
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount+1))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = DateFormatter.Style.short
            
            return formatter.string(from: sleepTime)
            
        }
        catch{
            print("Fetching prediction from model resulted in an error!")
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
    
    var body: some View {
        
        NavigationView{
            
            Form{
                
                Section(header: Text("When do you want to wake up?").sectionTitle()){
                    DatePicker(selection: $wakeUp, displayedComponents: .hourAndMinute){
                        Text("Please enter a time")
                        }.labelsHidden().datePickerStyle(WheelDatePickerStyle())
                }

                
                Section(header: Text("Desired amount of sleep").sectionTitle()){
                    Stepper("\(sleepAmount, specifier:"%g") hours", value: $sleepAmount, in: 4...12, step: 0.25)
                        .accessibility(value: Text("\(sleepAmount, specifier:"%g") Hours"))
                }
                
                
                Section(header: Text("Daily coffe intake").sectionTitle()){
                    Picker(coffeeAmount == 0 ? "1 cup" : "\(coffeeAmount+1) cups", selection: $coffeeAmount) {
                        ForEach(1..<21) { amount in
                            amount == 1 ? Text("1 cup") : Text("\(amount) cups")
                        }
                    }
                }
                
                Section(header: Text("Your ideal sleep time is ...").font(.headline).foregroundColor(.primary)){
                    Text("\(bedTime)").font(.title)
                }


            }.navigationBarTitle("BetterRest")

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
