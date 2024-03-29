//
//  ContentView.swift
//  FlockPocket
//
//  Created by snow on 12/5/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let loggedIn = UserDefaults.standard.bool(forKey: "usernameAndPasswordSaved")
    @State private var showLoginView: Bool = false
    
    @State private var inviteEmail = "isaac+something@snowskeleton.net"
    
    var body: some View {
        TabView {
            AllThreadsView()
                .tabItem {
                    Label("Messages", systemImage: "message")
                }
            DirectoryView()
                .tabItem {
                    Label("Directory", systemImage: "person.3.sequence")
                }
            SettingsView()
                .badge("!")
                .tabItem {
                    Label("Account", systemImage: "gear")
                }
        }
        .onNotification { notification in
            print("Printing notification content")
            print(notification.notification.request.content.userInfo)
        }
        .onAppear() {
            if !loggedIn {
                showLoginView = true
            } else {
                WebSocket.shared.login()
            }
        }
        .onDisappear() {
            WebSocket.shared.disconnect()
        }
        .sheet(isPresented: $showLoginView) {
            LoginView()
        }
    }
}
