//
//  LoginView.swift
//  Testes-Unitarios-Projeto
//
//  Created by Leonardo Mesquita Alves on 26/04/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @Environment(AuthManager.self) var authManager
 
    @Binding var userAuthenticated: Bool
    
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            NavigationLink {
                HomeView(userAuthenticated: $userAuthenticated, email: $email, password: $password, name: $name)
            } label: {
                Text("Login")
                    .bold()
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue))
                    .foregroundStyle(.white)
            }
            .simultaneousGesture(TapGesture().onEnded({ _ in
                print("logou")
                signInStudent()
            }))
            
        }
        .padding()
        
    }
 
}

extension LoginView {
    
    func signInStudent() {
        guard !email.isEmpty, !password.isEmpty else {
            print("User can't log in")
            return
        }
        
        Task {
            do {
                let userReturned = try await authManager.login(email: email, password: password)
                print("User Logged")
                print(userReturned)
            } catch {
                print("Error in create user: \(error.localizedDescription)")
            }
        }
    }
    
}

#Preview {
    let auth = AuthManager()
    return LoginView(
        userAuthenticated: .constant(false),
        email: .constant("1234@gmail.com"),
        password: .constant("password"),
        name: .constant("Victor")
    )
    .environment(auth)
}
