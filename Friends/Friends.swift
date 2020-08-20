//
//  Friends.swift
//  Friends
//
//  Created by Japneet Singh on /208/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct Friends: View {
    var friends: [Friend]
    var users: [User]
    let colors = [Color.green, Color.yellow, Color.orange, Color.blue]
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                ForEach(friends){friend in
                    NavigationLink(destination: DetailView(user: self.users.first(where: {$0.id == friend.id})!, users: self.users)){
                        
                        HStack{
                            VStack{
                                HStack{
                                    Text("\(friend.name)")
                                        .fontWeight(.semibold)
                                        .padding(.leading, 5)
                                        .foregroundColor(.white)
                                    Spacer()
                                    
                                    VStack{
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                        Spacer()
                                    }

                                }
                                HStack{

                                    Text("\(self.users.first(where: {$0.id == friend.id})!.age) years")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .padding(.leading, 5)
                                    
                                    Circle()
                                        .frame(width: 10, height: 10, alignment: .center)
                                        .foregroundColor(.white)
                                    
                                    Text("\(self.users.first(where: {$0.id == friend.id})!.company)")
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .padding(.leading, 5)
                                    
                                    Spacer()
                                }
                                
                            }
                                .padding()
                            .background(self.colors.randomElement())
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }

                    }
                }
            }
        }
    }
}

struct Friends_Previews: PreviewProvider {
    static var previews: some View {
        Friends(friends: [Friend(id: "svcac", name: "Remi Jordan")], users: [User]())
    }
}
