//
//  SessionManager.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-27.
//

import Foundation

class SessionManager {
    
    func getLoggedState() -> Bool {
        return UserDefaults.standard.bool(forKey: "USER_LOGGED")
    }
    
    func saveUserLogin() {
        UserDefaults.standard.set(true, forKey: "USER_LOGGED")
    }
    
    func clearUserLoggedState() {
        UserDefaults.standard.set(false, forKey: "USER_LOGGED")
    }
    
}
