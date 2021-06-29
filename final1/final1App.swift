//
//  final1App.swift
//  final1
//
//  Created by Eat Myself on 2021/6/28.
//

import SwiftUI
import Firebase

@main
struct final1App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var login = false
    var body: some Scene {
        WindowGroup {
            Group{
                if login{
                    ContentView()
                }
                else{
                    loginn()
                }
            }
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                   if let user = user {
                    login = true
                   } else {
                    login = false
                   }
                }
            }
        }
    }
}
