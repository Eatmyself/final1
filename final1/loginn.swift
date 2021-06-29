//
//  loginn.swift
//  final1
//
//  Created by Eat Myself on 2021/6/28.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct loginn: View {
    @State private var namestr = ""
    @State private var emailstr = ""
    @State private var passwordstr = ""
    @State private var state = true
    var body: some View {
        VStack{
            Text( state ? "Sign in":"Sign up")
            .font(.title)
            Group{
                if state==false{
                    HStack{
                        Text("name")
                            .font(.subheadline)
                        TextField("", text: $namestr)
                    }
                }
                HStack{
                    Text("email")
                        .font(.subheadline)
                    TextField("", text: $emailstr)
                }
                HStack{
                    Text("password")
                        .font(.subheadline)
                    TextField("", text: $passwordstr)
                }
            }
            .padding(.leading, 20)
            Button("Submit"){
                if state == false{
                    Auth.auth().createUser(withEmail: emailstr, password: passwordstr) { result, error in
                        
                        guard let user = result?.user,
                               error == nil else {
                            print(error?.localizedDescription)
                            return
                        }
                        print(user.email, user.uid)
                        let db = Firestore.firestore()
                        let u = Userdata(name: namestr, time: Date(), face: 0, accessoriese:0, bodyimg:0, facial:0, head:0)
                        do {
                            try db.collection("userdata").document(user.uid).setData(from: u)
                        } catch {
                            print(error)
                        }
                    }
                }
                else{
                    Auth.auth().signIn(withEmail: emailstr, password: passwordstr) { result, error in
                         guard error == nil else {
                            print(error?.localizedDescription)
                            return
                         }
                    }
                }
                if let user = Auth.auth().currentUser {
                    let db = Firestore.firestore()
                    db.collection("userdata").document(user.uid).getDocument { document, error in
                                
                         guard let document = document,
                               document.exists,
                               let u = try? document.data(as: Userdata.self) else {
                              return
                         }
                        namestr = u.name
                             
                    }
                }
                
            }
            .foregroundColor(.green)
            .font(.title3)
            .padding(5)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.green, lineWidth: 3)
            )
            Button(state ? "Sign up?":"Sign in?"){
                state.toggle()
            }
        }
        
    }
}

struct loginn_Previews: PreviewProvider {
    static var previews: some View {
        loginn()
    }
}
