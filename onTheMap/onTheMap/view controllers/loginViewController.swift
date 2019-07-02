//
//  loginViewController.swift
//  onTheMap
//
//  Created by albandry on 26/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import Foundation
import UIKit

class loginViewController : UIViewController  {
    
  //  var alerts = General()
    
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.setTitleColor(.white, for: .normal)
        
        mailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.isEnabled = false
        
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        UdacityClient.loginSession(username: mailTextField.text ?? "" , password: passwordTextField.text ?? "" ) { (secssus, error) in
            if secssus {
                self.handleLoginResponse(true , error: nil)
            } else {
                self.handleLoginResponse(false, error: error)
            }
        }
        
    }
    
    func handleLoginResponse(_ login:Bool,error:Error?) {
        if login {
            DispatchQueue.main.async {
                MapClient.getcurrentUser()
                self.setUpindicator(indicator: self.activityIndecator)
                self.performSegue(withIdentifier: "accountView", sender: nil)
                MapClient.getStudentLocation(completion: { (studentLocation, error) in
                    SavedStudentResult.results = studentLocation
                })
            }
            
        } else {
            DispatchQueue.main.async {
                self.setUpindicator(indicator: self.activityIndecator)
                self.printAlert("login Failure", "check your internet connection")
            }
        }
    }
    
    
    
    @IBAction func TextFieldEditingDidChanged(_ sender: Any) {
        
        if checkTextFields(text: passwordTextField, text2: mailTextField) == true{
           loginButton.isEnabled = true
        } else {
           printAlert("login Failure", "you have to enter both password and Email")
            loginButton.isEnabled = false
        }
    }
    
    func checkTextFields(text : UITextField , text2 : UITextField) -> Bool {
        if text.text!.isEmpty || text2.text!.isEmpty {
            return false
        } else {
            return true
        }
    }
    
  
    
    
    @IBAction func signUp(_ sender: Any) {
        let signURL = URL(string: "https://auth.udacity.com/sign-up")
        if let signURL = signURL {
            UIApplication.shared.open(signURL, options: [:], completionHandler: nil)
        }
    }
    
}
extension loginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == mailTextField {
            mailTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
    

    
}

