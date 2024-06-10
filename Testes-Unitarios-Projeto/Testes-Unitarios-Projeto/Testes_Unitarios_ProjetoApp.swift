//
//  Testes_Unitarios_ProjetoApp.swift
//  Testes-Unitarios-Projeto
//
//  Created by Leonardo Mesquita Alves on 26/04/24.
//

import SwiftUI
import Firebase

@main
struct Testes_Unitarios_ProjetoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
 
    @State var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .environment(authManager)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
}
