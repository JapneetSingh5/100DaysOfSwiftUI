//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Japneet Singh on /78/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: OrderClass

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.order.name)
                TextField("Street Address", text: $order.order.streetAddress)
                TextField("City", text: $order.order.city)
                TextField("Zip", text: $order.order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }.disabled(!order.order.hasValidAddress)
        }
        .navigationBarTitle("Delivery details")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: OrderClass())
    }
}
