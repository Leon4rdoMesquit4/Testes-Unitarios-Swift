//
//  HomeView.swift
//  Testes-Unitarios-Projeto
//
//  Created by Victor Hugo Pacheco Araujo on 29/04/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var authManager = AuthManager()
    
    @Binding var userAuthenticated: Bool
    
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    
    var body: some View {
        
        VStack {
            
            Text("Name: \(name)")
                .padding()
            
            NavigationLink {
                AuthenticationView(userAuthenticated: $userAuthenticated, email: $email, password: $password, name: $name
                )
                .environment(authManager)
                
            } label: {
                Text("LogOut")
                    .bold()
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue))
                    .foregroundStyle(.white)
            }
            .simultaneousGesture(TapGesture().onEnded({ _ in
                do {
                    try logOut()
                    print("deslogou")
                } catch {
                    print("Nao deslogou")
                }
            }))
            
        }
        
    }
}


extension HomeView {
    
    mutating func getEmail() async throws -> String {
        let authUser = try authManager.getStudentAuthenticated()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        self.email = email
        return email
    }
    
    mutating func getUserName() async throws -> String {
        let authUser = try authManager.getStudentAuthenticated()
        
        guard let name = authUser.name else {
            throw URLError(.fileDoesNotExist)
        }
        
        self.name = name
        return name
    }
    
    func logOut() throws {
        try authManager.signOut()
    }
    
}

#Preview {
    let auth = AuthManager()
    return HomeView(
        userAuthenticated: .constant(false),
        email: .constant("email@gmail.com"),
        password: .constant("password1234"),
        name: .constant("Victor")
    )
    .environment(auth)
}
