//
//  SignUpStudentView.swift
//  Testes-Unitarios-Projeto
//
//  Created by Victor Hugo Pacheco Araujo on 26/04/24.
//

import SwiftUI
import FirebaseAuth

struct SignUpStudentView: View {
    
    @Environment(AuthManager.self) var authManager

    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    
    @Binding var userAuthenticated: Bool
    
    var body: some View {
        
        VStack {
            
            TextField("Nome", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.vertical)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
        
            NavigationLink {
                HomeView(userAuthenticated: $userAuthenticated, email: $email, password: $password, name: $name)
            } label: {
                Text("Cadastrar")
                    .bold()
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue))
                    .foregroundStyle(.white)
            }
            .simultaneousGesture(TapGesture().onEnded({ _ in
                signUpStudent()
            }))
            
        }
        
        .padding()
        .navigationTitle("Cadastro")
        
    }
    
}

extension SignUpStudentView {
    
    func signUpStudent() {
        guard !email.isEmpty, !password.isEmpty else {
            print("User can't be created")
            return
        }
        
        Task {
            do {
                var userReturned = try await authManager.createStudentUser(email: email, password: password)
                
                userReturned.name = self.name
                
                print("User Created")
                print(userReturned)
            } catch {
                print("Error in create user: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    let auth = AuthManager()
    return SignUpStudentView(
        email: .constant("teste@gmail.com"),
        password: .constant("12345678"),
        name: .constant("Victor"),
        userAuthenticated: .constant(false)
    )
    .environment(auth)
}
