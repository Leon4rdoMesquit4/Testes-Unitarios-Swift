//
//  Student.swift
//  Testes-Unitarios-Projeto
//
//  Created by Victor Hugo Pacheco Araujo on 29/04/24.
//

import Foundation
import FirebaseAuth

struct StudentAuthModel {
    var uid: String
    var name: String?
    var cpf: String
    var email: String?
    var phone: String?
    
    init(user: User) {
        self.uid = user.uid
        self.name = user.displayName
        self.cpf = user.providerID
        self.email = user.email
        self.phone = user.phoneNumber
    }
    
}
