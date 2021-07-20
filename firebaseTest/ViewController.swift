//
//  ViewController.swift
//  firebaseTest
//
//  Created by Jigyasaa Sood on 7/7/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var emailField: UITextField!
    var pwField: UITextField!
    var loginBtn: UIButton!
    var signupBtn: UIButton!
    
    var ref: DatabaseReference!


    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        
        //create UI elements
        
        emailField = UITextField()
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.placeholder = "Enter email..."
        emailField.borderStyle = .roundedRect
        view.addSubview(emailField)
        
        pwField = UITextField()
        pwField.translatesAutoresizingMaskIntoConstraints = false
        pwField.placeholder = "Enter password..."
        pwField.borderStyle = .roundedRect
        view.addSubview(pwField)
        
        loginBtn = UIButton()
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.backgroundColor = UIColor.blue
        loginBtn.setTitle("Login", for: .normal)
        view.addSubview(loginBtn)
        loginBtn.addTarget(self, action: #selector(loginUser), for: .allEvents)
        
        signupBtn = UIButton()
        signupBtn.translatesAutoresizingMaskIntoConstraints = false
        signupBtn.backgroundColor = UIColor.green
        signupBtn.setTitle("Sign up", for: .normal)
        view.addSubview(signupBtn)
        signupBtn.addTarget(self, action: #selector(signupUser), for: .allEvents)
        
        //add constraints
        
        NSLayoutConstraint.activate([
        
            emailField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            emailField.widthAnchor.constraint(equalToConstant: 200),
            
            pwField.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            //pwField.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            pwField.topAnchor.constraint(equalTo: emailField.layoutMarginsGuide.bottomAnchor, constant: 25),
            pwField.widthAnchor.constraint(equalToConstant: 200),
            
            loginBtn.leadingAnchor.constraint(equalTo: pwField.layoutMarginsGuide.leadingAnchor),
            loginBtn.topAnchor.constraint(equalTo: pwField.layoutMarginsGuide.bottomAnchor, constant: 50),
            
            signupBtn.leadingAnchor.constraint(equalTo: loginBtn.layoutMarginsGuide.trailingAnchor, constant: 100),
            signupBtn.topAnchor.constraint(equalTo: pwField.layoutMarginsGuide.bottomAnchor, constant: 50)
            
            
        
        ])
        
        
        
    }
    
    @objc func signupUser() {
        if(emailField.text != "" && pwField.text! != ""){
        Auth.auth().createUser(withEmail: emailField.text!, password: pwField.text!) { authResult, error in
            if(error != nil){
                //alert messages...
                print("Error adding a new user: \(error?.localizedDescription)")
            }
            else {
                self.ref.child("users").child((authResult?.user.uid)!).setValue(["email": self.emailField.text])
            }
        }
        }
        else{
            
            //alert message to display to the user why the signup failed
            
            print("email and password fields cannot be empty, please double check!")
        }
        
    }
    
    @objc func loginUser() {
        if(emailField.text != "" && pwField.text! != ""){
        Auth.auth().signIn(withEmail: emailField.text!, password: pwField.text!) { [weak self] authResult, error in
            
            if(error != nil){
                print("Error logging in: \(error?.localizedDescription)")
            }
            else if (authResult != nil){
                print("User successfully logged in!")
            }
        }
        }
        else{
            //alert message to display to the user why the login failed
            
            print("email and password fields cannot be empty for login, please double check!")
        }
        
    }
    
    
    


}

