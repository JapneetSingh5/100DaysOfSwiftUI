//
//  ContentView.swift
//  Roll
//
//  Created by Japneet Singh on /209/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State var counter = 0
    @State var maxNumber = 0
    @State var numberShow = 0
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Roll.time, ascending: false)]) var historyRoll: FetchedResults<Roll>
    let sides = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 24, 30, 32, 34, 48, 50, 60, 100, 120, 144]
    
    func roll(){

        self.counter = 0
        simpleSuccess()
        
        let roll = Roll(context: self.moc)
        roll.diceCount = 1
        roll.result = Int16(self.numberShow)
        roll.sides = Int16(maxNumber)
        roll.time = Date()
        if self.moc.hasChanges{
            try? self.moc.save()
        }
    }
    
    func simpleSuccess(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
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
                                .onReceive(timer){_ in
                                    if self.counter<=5{
                                        self.counter+=1
                                                            self.numberShow = Int.random(in: 1...self.maxNumber+1)
                                        }
                                    }
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
