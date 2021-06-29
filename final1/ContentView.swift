//
//  ContentView.swift
//  Firebase
//
//  Created by Eat Myself on 2021/6/27.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ContentView: View {
@State private var username = ""
@State private var email = ""
@State private var day = Date()
@State private var face = 0
@State private var accessoriese = 0
@State private var bodyimg = 0
@State private var facial = 0
@State private var head = 0
@State private var tab = 0
var faces = ["Calm", "Loving Grin 2", "Cyclops", "Eyes Closed", "Concerned", "Concerned Fear", "Solemn", "Suspicious", "Eating Happy", "Smile Big", "Monster", "Cheeky", "Very Angry", "Rage", "Explaining", "Smile Teeth Gap", "Blank", "Fear", "Serious", "Smile LOL", "Loving Grin 1", "Old", "Cute", "Driven", "Angry with Fang", "Tired", "Smile", "Awe", "Contempt", "Hectic"]
var accessorieses = ["Noneacc", "Glasses 5", "Glasses 4", "Eyepatch", "Sunglasses", "Glasses 2", "Glasses 3", "Sunglasses 2", "Glasses"]
var bodys = ["Gaming", "Button Shirt 1", "Tee 1", "Polka Dot Jacket", "Thunder T-Shirt", "Blazer Black Tee", "Polo and Sweater", "Gym Shirt", "Dress", "Hoodie", "Striped Pocket Tee", "Paper", "Whatever", "Sweater", "Tee Selena", "Explainingc", "Tee Arms Crossed", "Sweater Dots", "Shirt and Coat", "Fur Jacket", "Macbook", "Coffee", "Button Shirt 2", "Tee 2", "Killer", "Striped Tee", "Device", "Pointing Up", "Sporty Tee", "Turtleneck"]
var facials = ["Nonehair", "Moustache 8", "Moustache 9", "Moustache 2", "Moustache 3", "Full 4", "Full", "Moustache 5", "Moustache 4", "Full 3", "Full 2", "Goatee 1", "Moustache 1", "Goatee 2", "Chin", "Moustache 6", "Moustache 7"]
var heads = ["Gray Short", "Bear", "Short 2", "Short 3", "Pomp", "Medium Straight", "hat-beanie", "Cornrows 2", "Afro", "Medium 2", "Long", "Medium 3", "Hijab", "Shaved 1", "Long Curly", "No Hair 1", "hat-hip", "Twists 2", "Turban", "Gray Medium", "Short 5", "Short 4", "Mohawk 2", "Buns", "Flat Top Long", "Bun", "Bun 2", "Medium 1", "Medium Bangs 3", "Medium Bangs 2", "Bantu Knots", "Bangs", "Cornrows", "Short 1", "Long Afro", "Flat Top", "Twists", "Long Bangs", "Gray Bun", "Mohawk", "Bangs 2", "Medium Bangs", "Shaved 2", "Shaved 3", "No Hair 2", "No Hair 3"]
    var body: some View {
        ZStack{
            VStack {
                ZStack{
                    Image(bodys[bodyimg])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .offset(x: 20, y: 150)
                    Image(heads[head])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .offset(x: 50, y: -80)
                    Image(accessorieses[accessoriese])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .offset(x: 55, y: -70)
                    Image(facials[facial])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 110, height: 110)
                        .offset(x: 50, y: -5)
                    Image(faces[face])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .offset(x: 75, y: -60)
                }
                .frame(height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Form{
                    HStack{
                        Button(action: {
                            face = Int.random(in: 0...faces.count-1)
                            head = Int.random(in: 0...heads.count-1)
                            bodyimg = Int.random(in: 0...bodys.count-1)
                            accessoriese = Int.random(in: 0...accessorieses.count-1)
                            facial = Int.random(in: 0...facials.count-1)
                        }){
                            Image("dice")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                        }
                    }
                    
                    Picker(selection: $tab, label: Text("tab")) {
                                            Text("head").tag(0)
                                            Text("face").tag(1)
                                            Text("body").tag(2)
                                            Text("accessoriese").tag(3)
                                            Text("facial hair").tag(4)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    
                        if  tab==0{
                            Picker(selection: $head, label: Text("head")) {
                                ForEach(heads.indices) { (index) in
                                                    Text(heads[index]).tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        else if tab==1{
                            Picker(selection: $face, label: Text("head")) {
                                ForEach(faces.indices) { (index) in
                                                    Text(faces[index]).tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        else if tab==2{
                            Picker(selection: $bodyimg, label: Text("head")) {
                                ForEach(bodys.indices) { (index) in
                                                    Text(bodys[index]).tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        else if tab==3{
                            Picker(selection: $accessoriese, label: Text("head")) {
                                ForEach(accessorieses.indices) { (index) in
                                                    Text(accessorieses[index]).tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        else if tab==4{
                            Picker(selection: $facial, label: Text("head")) {
                                ForEach(facials.indices) { (index) in
                                                    Text(facials[index]).tag(index)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                   
                }
            }
            Button("Save"){
                if let user = Auth.auth().currentUser {
                    let db = Firestore.firestore()
                    let documentReference = db.collection("userdata").document(user.uid)
                    documentReference.getDocument { document, error in
                        guard let document = document, document.exists, var u = try? document.data(as: Userdata.self)
                        else {
                            return
                        }
                        let tmp = Userdata(name: u.name, time: u.time, face: face, accessoriese:accessoriese, bodyimg:bodyimg, facial:facial, head:head)
                        do {
                            try documentReference.setData(from: tmp)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .position(x: 40, y: 10)
            Button("Logout"){
                do {
                   try Auth.auth().signOut()
                } catch {
                   print(error)
                }
            }
            .position(x: 320, y: 10)
            Group{
                Text("\(username)\n\n\(email)\n\n\(day, style: .date)")
                        .position(x: 70, y: 90)
                Text("Email:")
                    .font(.footnote)
                    .position(x: 30, y: 75)
                Text("Since:")
                    .font(.footnote)
                    .position(x: 30, y: 120)
            }
        }
        .onAppear{
            if let user = Auth.auth().currentUser {
                let db = Firestore.firestore()
                db.collection("userdata").document(user.uid).getDocument { document, error in
                     guard let document = document,
                           document.exists,
                           let u = try? document.data(as: Userdata.self)
                     else {
                          return
                     }
                    username = u.name
                    email = user.email!
                    day = u.time
                    face = u.face
                    accessoriese = u.accessoriese
                    bodyimg = u.bodyimg
                    facial = u.facial
                    head = u.head
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
