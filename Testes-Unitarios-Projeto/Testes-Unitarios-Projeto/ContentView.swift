//
//  ContentView.swift
//  Testes-Unitarios-Projeto
//
//  Created by Leonardo Mesquita Alves on 26/04/24.
//

import SwiftUI

struct ContentView: View {
        
    @Environment(AuthManager.self) var authManager
    
    @AppStorage("userAuthenticated") var userAuthenticated = false
    
    @State var email: String = ""
    @State var password: String = ""
    @State var name: String = ""
    
    var body: some View {
        
        if userAuthenticated == true {
            
        }
        
        VStack {
            
            HomeView(userAuthenticated: $userAuthenticated, email: $email, password: $password, name: $name)
            
        }
        .onAppear(perform: {
            let authUser = try? authManager.getStudentAuthenticated()
            
            if authUser == nil {
                userAuthenticated = false
            } else {
                userAuthenticated = true
            }
           
        })
        
        .fullScreenCover(isPresented: $userAuthenticated, content: {
            AuthenticationView(userAuthenticated: $userAuthenticated, email: $email, password: $password, name: $name)
        })
        
    }
}

#Preview {
    let authManager = AuthManager()
    return NavigationStack {
        ContentView()
            .environment(authManager)
    }
}
