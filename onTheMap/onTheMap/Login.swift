//
//  Login.swift
//  onTheMap
//
//  Created by albandry on 22/05/2019.
//  Copyright © 2019 albandry. All rights reserved.
//

import UIKit

class Login : UIViewController , UITextFieldDelegate{
    
 
    @IBOutlet weak var loginButton: UIButton!
     
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var passTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailTextField.delegate = self
        passTextField.delegate = self
        passTextField.isSecureTextEntry = true

    }
    
    
  
    @IBAction func login(_ sender: Any) {
        isValid()
        udacityClient.createSession( username: EmailTextField.text ?? "", password: passTextField.text ?? "") { (success , error) in
            if success {
                self.handleLoginResponse(success: true, error: nil)
            } else {
                self.handleLoginResponse(success: false, error: error)
            }
        }
        
    }
    
     func handleLoginResponse(success: Bool , error: Error?){
        
        if success {
             DispatchQueue.main.async {
            udacityClient.currentUser()
            self.performSegue(withIdentifier: "goInsideTheApp", sender: nil)
            mapClinet.studentLocation (completion: { (studentLocation, error) in
                studentData.data = studentLocation })
            }
        } else {
            DispatchQueue.main.async {
                self.errorAlert(title: "Error", message: error?.localizedDescription ?? "" )
            }
        }
    }
    

    
    @IBAction func signin(_ sender: Any) {
        let app = UIApplication.shared
  if let url = URL(string: "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated") {
        app.open(url, options: [:] , completionHandler: nil)
  } else {
    errorAlert(title: "Error", message: "something went wrong")
        }
    }
    
    func isValid() {
        //Case1: if the user didnt enter the pass and name or one of them didnt entered
        if EmailTextField.text!.isEmpty || passTextField.text!.isEmpty {
            errorAlert(title: "Error", message: "Enter both your Email and password")
            return
        }
        //Case2: if the email is wrong
        if EmailTextField.text!.contains("@") == false && EmailTextField.text!.contains(".") == false {
            errorAlert(title: "Error", message: "Email is wrong!")
                }
    }
    
    func errorAlert(title : String , message : String ) {
        let alert = UIAlertController(title: title , message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
