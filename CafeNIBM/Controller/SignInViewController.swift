//
//  SignInViewController.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-25.
//

import UIKit
import Firebase
import Loaf

class SignInViewController: UIViewController {

    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func onSignInPressed(_ sender: UIButton) {
        if validInput(){
            authUser(email: txtEmail.text!, password: txtPassword.text!)
        }else{
            print("Input error found")
        }

    }
    
    func validInput() -> Bool {
        guard let email = txtEmail.text else {
            return false
        }
        guard let password = txtPassword.text else {
            return false
        }
        if email.count < 11 {
//            print("Enter a valid Email")
            Loaf("Enter a valid Email !", state: .error, sender: self).show()
            return false
        }
        if password.count < 6 {
//            print("Enter a valid Password")
            Loaf("Enter a valid Password !", state: .error, sender: self).show()
            return false
        }
        
        return true
    }
    
    func authUser(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                Loaf("Email or Password is Invalid !", state: .error, sender: self).show()
                return
            }
            
            if let result = authResult {
                print("User email : \(result.user.email ?? "Not Found")")
            }
            
            // Save user logged in state
            let sessionManager = SessionManager()
            sessionManager.saveUserLogin()
            self.performSegue(withIdentifier: "SignInToHome", sender: nil)
            
            
        }
    }
    
}
