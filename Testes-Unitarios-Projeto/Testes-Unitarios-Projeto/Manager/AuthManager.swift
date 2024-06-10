//
//  DataManager.swift
//  Testes-Unitarios-Projeto
//
//  Created by Victor Hugo Pacheco Araujo on 26/04/24.
//

import SwiftUI
import Firebase

@Observable
class AuthManager {
    
//    @discardableResult
    func createStudentUser(email: String, password: String) async throws -> StudentAuthModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return StudentAuthModel(user: authDataResult.user)
    }
    
//    @discardableResult
    func login(email: String, password: String) async throws -> StudentAuthModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return StudentAuthModel(user: authDataResult.user)
    }
    
    func getStudentAuthenticated() throws -> StudentAuthModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return StudentAuthModel(user: user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
    
}
