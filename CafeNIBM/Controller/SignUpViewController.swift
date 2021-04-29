//
//  SignUpViewController.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-25.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtMobileNo: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSignInPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion:nil)
    }
    
    
    @IBAction func onSignUpPressed(_ sender: UIButton) {
        if validInput(){
            registerUser(email: txtEmail.text!, password: txtPassword.text!)
        }else{
            print("Input error found")
        }
    }
    
    func validInput() -> Bool {
        guard let email = txtEmail.text else {
            return false
        }
        guard let mobile = txtMobileNo.text else {
            return false
        }
        guard let password = txtPassword.text else {
            return false
        }
        if email.count < 11 {
            print("Enter a valid Email")
            return false
        }
        if password.count < 6 {
            print("Enter a valid Password")
            return false
        }
        
        if mobile.count < 10 {
            print("Enter a valid Mobile No")
            return false
        }
        
        
        return true
    }
    
    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) {
            authResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let result = authResult {
                print("User email : \(result.user.email ?? "Not Found")")
            }
        }
    }

}
