//
//  AddView.swift
//  iExpense
//
//  Created by Japneet Singh on /277/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount = ""
    @State private var showingAlert = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                Picker("Type", selection: $type){
                    ForEach(AddView.types, id:\.self){
                        Text($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                TextField("Amount", text: $amount).keyboardType(.decimalPad)
            }
            .navigationBarTitle("Add New Expense")
            .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Cancel")
            },trailing: Button("Save") {
                if let actualAmount = Double(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                    return
                }
                
                self.showingAlert.toggle()
            })
            
        }.alert(isPresented: $showingAlert){
            Alert(title: Text("Invalid Amount"), message :Text("Amount must be a valid number"), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}


