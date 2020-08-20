//
//  DetailView.swift
//  Friends
//
//  Created by Japneet Singh on /208/20.
//  Copyright © 2020 Japneet Singh. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var user: User
    var users: [User]
    let colors = [Color.green, Color.yellow, Color.orange, Color.blue]
    var body: some View {
        ScrollView{
            HStack{
                Capsule()
                    .frame(width: 120, height: 30)
                    .foregroundColor(user.isActive ? .green : .red)
                    .overlay(
                        Text(user.isActive ? "ACTIVE" : "INACTIVE")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding()
                            )
                    .padding(.leading, 20)
                Text("Friend since \(user.registered.components(separatedBy: "T")[0].components(separatedBy: "-")[2])/\(user.registered.components(separatedBy: "T")[0].components(separatedBy: "-")[1])/\(user.registered.components(separatedBy: "T")[0].components(separatedBy: "-")[0])".uppercased())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                Spacer()
            }
            ScrollView(.horizontal){
                HStack{
                    ForEach(0..<user.tags.count){count in
                        Capsule()
                            .frame(width: 120, height: 30)
                            .foregroundColor(self.colors[count%4])
                            .overlay(
                                Text("\(self.user.tags[count])")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding()
                                    )
                    }
                }
            }
            .cornerRadius(20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            
            ScrollView(.horizontal){
                HStack{
                    Text("\(user.age) years")
                        .font(.title)
                        .fontWeight(.medium)
                    Circle()
                        .frame(width: 10, height: 10, alignment: .center)
                    Text("\(user.company)")
                        .font(.title)
                        .fontWeight(.medium)
                }
            }
            .padding(.leading, 25)
            .padding(.trailing, 20)
            .padding(.top, 10)
            
            VStack{
                HStack{
                    Text("\(user.email)")
                    .fontWeight(.medium)
                    .padding(.leading, 25)
                    .padding(.trailing, 20)
                    Spacer()
                }
                HStack{
                    Text("\(user.about)")
                    .fontWeight(.medium)
                    .padding(.leading, 25)
                    .padding(.trailing, 20)
                    Spacer()
                }
                .padding(.top, 10)
            }
            
            HStack{
                Text("\(user.address)")
                .fontWeight(.medium)
                .padding(.leading, 25)
                .padding(.trailing, 20)
                Spacer()
            }
            
            HStack{
                Text("Friends")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.leading, 25)
                    .padding(.top, 20)
                Text("\(user.friends.count)")
                    .foregroundColor(.secondary)
                    .padding(.top, 25)
                Spacer()
            }

            Friends(friends: user.friends, users: users)



            
        }
        .navigationBarTitle("\(user.name)")
            
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n", registered: "2015-11-10T01:47:18-00:00", tags: ["cillum", "consequat", "deserunt", "nostrud", "eiusmod", "minim", "tempor"], friends: [Friend]())
            , users: [User]())
    }
}
