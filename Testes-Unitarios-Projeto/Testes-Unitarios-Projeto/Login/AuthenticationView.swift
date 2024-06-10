//
//  AuthenticationView.swift
//  Testes-Unitarios-Projeto
//
//  Created by Victor Hugo Pacheco Araujo on 10/06/24.
//

import SwiftUI

struct AuthenticationView: View {
 
    @Binding var userAuthenticated: Bool
    
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    
    var body: some View {
        NavigationStack {
            
            VStack {
                LoginView(userAuthenticated: $userAuthenticated, email: $email, password: $password, name: $name)
                
                Text("Ainda nao tem cadastro?")
                
                NavigationLink("Cadastre-se") {
                    SignUpStudentView(email: $email, password: $password, name: $name, userAuthenticated: $userAuthenticated)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            
        }
        
    }
}

#Preview {
    AuthenticationView(userAuthenticated: .constant(false), email: .constant("teste@gmail.com"), password: .constant("12345"), name: .constant("victor"))
}
