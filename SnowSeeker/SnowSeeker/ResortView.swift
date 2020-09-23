//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Japneet Singh on /229/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    @EnvironmentObject var favorites: Favorites
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedFacility: Facility?
    let resort: Resort

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(
                        VStack{
                            Spacer()
                            HStack{
                                Spacer()
                                Text(resort.imageCredit)
                                    .font(.caption)
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding(8)
                                    .background(colorScheme == .dark ? Color.black : Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(5)
                            }
                        }
                    )

                Group {
                    
                    HStack {
                        if sizeClass == .compact{
                            VStack{
                                ResortDetailsView(resort: resort)
                            }
                                .padding()
                            VStack{
                                SkiDetailsView(resort: resort)
                            }
                            .padding()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                        
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                    
                    Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                        if self.favorites.contains(self.resort) {
                            self.favorites.remove(self.resort)
                        } else {
                            self.favorites.add(self.resort)
                        }
                    }
                    .padding(.vertical)
                    
                }
                .padding(.horizontal)
            }
        }
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
