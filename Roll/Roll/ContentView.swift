//
//  ContentView.swift
//  Roll
//
//  Created by Japneet Singh on /209/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var maxNumber = 0
    @State var numberShow = 0
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Roll.entity(), sortDescriptors: []) var historyRoll: FetchedResults<Roll>
    let sides = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 24, 30, 32, 34, 48, 50, 60, 100, 120, 144]
    
    func roll(){
        
        self.numberShow = Int.random(in: 1...sides[maxNumber]+1)
        
        let roll = Roll(context: self.moc)
        roll.diceCount = 1
        roll.result = Int16(self.numberShow)
        roll.sides = Int16(sides[maxNumber])
        if self.moc.hasChanges{
            try? self.moc.save()
        }
    }
    
    var body: some View {
        TabView{
            
            NavigationView{
                VStack{
                    Form{
                        Picker(selection: self.$maxNumber, label: Text("Number of sides"), content: {
                            ForEach(self.sides, id:\.self){side in
                                Text("D\(side)")
                            }
                        })
                        HStack{
                            Spacer()
                            DiceView(numberShown: self.$numberShow)
                                .padding()
                            Spacer()
                        }
                            Button("Roll"){
                                self.roll()
                            }
                        .padding()
                                .padding(.trailing, 30)
                                .padding(.leading, 30)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                        .cornerRadius(40)
                    }
                    
                }
            .navigationBarTitle("Roll")
            }
            .tabItem({
                Text("Roll")
                Image(systemName: "wand.and.stars")
            })
            
            NavigationView{
                List{
                    ForEach(historyRoll, id:\.self){roll in
                        HStack{
                            Text("\(roll.result)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Spacer()
                                Text("D\(roll.sides)")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            Text("·")
                                .fontWeight(.bold)
                                Text("1 Dice")
                                    .fontWeight(.bold)
                                    .font(.largeTitle)
                                
                        }
                    }
                }
            .navigationBarTitle("History")
            }
            .tabItem({
                Text("History")
                Image(systemName: "arrow.counterclockwise")
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
