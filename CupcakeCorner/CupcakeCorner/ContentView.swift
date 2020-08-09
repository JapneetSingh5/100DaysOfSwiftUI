//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Japneet Singh on /58/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

//class User: ObservableObject, Codable {
//    @Published var name = "Paul Hudson"
//
//    enum CodingKeys: CodingKey {
//        case name
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}
//
//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}

struct ContentView: View {
    @ObservedObject var order = OrderClass()

    var body: some View {
        NavigationView{
            Form {
                Section{
                    
                    Picker(selection: $order.order.type.animation(), label: Text("Select your cake")){
                        ForEach(0..<Order.types.count, id:\.self){
                            Text(Order.types[$0])
                                .fontWeight(.medium)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    
                    Stepper("Number of cakes: \(order.order.quantity)", value: $order.order.quantity, in: 3...20)
                }
                
                Section{
                    Toggle(isOn: $order.order.specialRequestEnabled.animation()){
                        Text("Any special requests? ")
                    }
                    
                    if(order.order.specialRequestEnabled){
                        Toggle(isOn: $order.order.extraFrosting){
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.order.addSprinkles){
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section{
                    NavigationLink(destination: AddressView(order: order)){
                        Text("Delivery Details")
                    }
                }
            }
        .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
