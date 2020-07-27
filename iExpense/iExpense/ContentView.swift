//
//  ContentView.swift
//  iExpense
//
//  Created by Japneet Singh on /267/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct HighAmount: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(.red)
    }
}
struct MediumAmount: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(.orange)
    }
}
struct LowAmount: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundColor(.green)
    }
}

extension View {
    func highAmount()->some View{
        self.modifier(HighAmount())
    }
    func mediumAmount()->some View{
        self.modifier(MediumAmount())
    }
    func lowAmount()->some View{
        self.modifier(LowAmount())
    }
}

struct User: Codable {
    var firstName: String
    var lastName: String
}


struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Group{
                            if(item.amount >= 100.0){
                                Text("$\(item.amount, specifier: "%g")").highAmount()
                            }
                            else if (item.amount >= 10.0 ){
                                Text("$\(item.amount, specifier: "%g")").mediumAmount()
                            }
                            else{
                                Text("$\(item.amount, specifier: "%g")").lowAmount()
                            }
                        }
                    }
                }.onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense = true
                }){
                    Image(systemName: "plus")
                }
            )

        }.sheet(isPresented: $showingAddExpense){
            AddView(expenses: self.expenses)
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
