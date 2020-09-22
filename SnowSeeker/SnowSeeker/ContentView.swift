//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Japneet Singh on /219/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @State private var sortKey: Resort.SortBy = .none
    @State private var showSortMenu = false
    @State private var showFilterMenu = false
    @State private var showCountrySheet = false
    @State private var filterPrice = 1
    @State private var filterSize = 1
    @State private var isFiltered = false
    @State private var filterCountry = ["Austria": true, "Canada": true, "France": true, "Italy": true, "United States":true]
    
    var resorts: [Resort]{
        self.filter(resorts: (Resort.sort(key: sortKey, resorts: Bundle.main.decode("resorts.json"))))
    }
    
    let prices = [1,2,3]
    let sizes = [1,2,3]
    let countries = ["Austria", "Canada", "France", "Italy", "United States"]
    
    func sizeTransform(size: Int)->String {
        switch size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    func filter(resorts: [Resort]) -> [Resort]{
        if self.isFiltered{
            return resorts.filter({
                (($0.price == self.filterPrice) && ($0.size == self.filterSize)) && (self.filterCountry[$0.country] ?? true)
            })
        }
        else{
            return resorts
        }
    }

    var body: some View {
        NavigationView{
            
            List{
                if self.showFilterMenu{
                     withAnimation{
                        VStack(alignment: .leading){
                            
                            Text("FILTER")
                                .fontWeight(.bold)
                            
                            Button(action: {
                                self.showCountrySheet = true
                                self.isFiltered = true
                            }){
                                Text("FILTER BY COUNTRY")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical)
                            .foregroundColor(.blue)
                            
                            Text("PRICE RANGE")
                                .font(.caption)
                                .fontWeight(.semibold)
                            
                            Picker(selection: self.$filterPrice, label: Text("Price Category"), content: {
                                ForEach(prices, id:\.self){price in
                                    Text(String.init(repeating: "$", count: price))
                                }
                            })
                            .pickerStyle(SegmentedPickerStyle())
                            
                            Text("SIZE RANGE")
                                .font(.caption)
                                .fontWeight(.semibold)
                            
                            Picker(selection: self.$filterSize, label: Text("Size Category"), content: {
                                ForEach(sizes, id:\.self){size in
                                    Text(self.sizeTransform(size: size))
                                }
                            })
                            .pickerStyle(SegmentedPickerStyle())
                            
                         }
                        .padding(.vertical)
                     }
                 }
                
                if resorts.isEmpty{
                    Text("Sorry! No matching results found.")
                }
                
                ForEach(resorts){resort in
                    NavigationLink(destination: ResortView(resort: resort)){
                        Image(resort.country)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1))
                        
                        VStack(alignment: .leading){
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                            
                        }
                        .layoutPriority(1)

                        
                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                                .foregroundColor(.red)
                        }
                    }
                }
                
                if self.isFiltered{
                    Button("RESET FILTER"){
                        self.isFiltered = false
                        self.showFilterMenu = false
                    }
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding(.vertical)
                }
                

            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action: {
                self.showFilterMenu.toggle()
                self.isFiltered = true
            }){
                Image(systemName: self.showFilterMenu ? "checkmark.circle.fill" :  "line.horizontal.3.decrease.circle" )
                },
                trailing: Button(action: {
                    self.showSortMenu = true
                }){
                    Image(systemName: "arrow.up.arrow.down")
                })
            .actionSheet(isPresented: self.$showSortMenu, content:
                {
                    ActionSheet(title: Text("Sort by"), message: Text("Choose how you want to sort your listing"), buttons: [
                        .default(Text("None"), action: {
                        self.sortKey = Resort.SortBy.none
                    }),
                        .default(Text("Alphabetical"), action: {
                            self.sortKey = Resort.SortBy.alphabetical
                        }),
                        .default(Text("Country"), action: {
                            self.sortKey = Resort.SortBy.country
                        }),
                        .cancel()
                    ])
            })
                .sheet(isPresented: self.$showCountrySheet){
                    MultiPickerView(choices: self.countries, selection: self.$filterCountry)
            }
            
            WelcomeView()
            
        }
        .environmentObject(self.favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
