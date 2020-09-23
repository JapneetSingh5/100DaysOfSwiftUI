//
//  MultiPickerView.swift
//  SnowSeeker
//
//  Created by Japneet Singh on /229/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct MultiPickerView: View {
    let choices: [String]
    @Binding var selection: [String: Bool]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView{
            List{
                ForEach(0..<choices.count){choiceNumber in
                    HStack{
                        Image(self.choices[choiceNumber])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        Text(self.choices[choiceNumber])
                        Spacer()
                        if(self.selection[self.choices[choiceNumber]] ?? true){
                            Image(systemName: "checkmark")
                        }
                    }
                .contentShape(Rectangle())
                    .onTapGesture {
                            self.selection[self.choices[choiceNumber]]?.toggle()
                    }
                }
            }
            .navigationBarItems(trailing: Button("Done"){
                self.presentationMode.wrappedValue.dismiss()
            })
            .navigationBarTitle("Filter Countries")
        }
    .navigationViewStyle(StackNavigationViewStyle())

    }
}

