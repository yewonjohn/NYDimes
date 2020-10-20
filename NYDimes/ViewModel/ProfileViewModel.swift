//
//  ProfileViewModel.swift
//  NYDimes
//
//  Created by John Kim on 10/19/20.
//

import Foundation
import FirebaseAuth

    class ProfileViewModel{
        
        let auth = AuthManager()
        let currentUser = Auth.auth().currentUser
                
        func signOut(){
            auth.signOut()
        }
        
        func getCurrentUser() -> User?{
            return currentUser
        }
        
        
    }
