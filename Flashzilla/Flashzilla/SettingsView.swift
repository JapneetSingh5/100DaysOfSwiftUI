//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Japneet Singh on /199/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var sendToBack: Bool
    var body: some View {
        NavigationView{
            Form{
                Section(footer: Text("By default, Flashzilla removes all swiped cards from the stack, checking this option will retain incorrectly guessed cards and push them at the bottom of the stack")){
                    Toggle(isOn: self.$sendToBack){
                        Text("Send X-marked cards to back")
                    }
                }
            }
        .navigationBarItems(trailing: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }){
            Text("Done")
                }
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(sendToBack: .constant(true))
    }
}
