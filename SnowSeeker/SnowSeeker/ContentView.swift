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
    
    var resorts: [Resort]{
        Resort.sort(key: sortKey, resorts: Bundle.main.decode("resorts.json"))
    }

    var body: some View {
        NavigationView{
            List(resorts){resort in
                
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
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: Button(action: {
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
