//
//  LogInVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 2/1/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInVC: UIViewController {
    
    let ds = DataService()
    var data: Dictionary<String, String> = [:]
    
    let bg: UIImageView = {
        let title = UIImageView()
        title.image = #imageLiteral(resourceName: "logInImg")
        title.contentMode = .scaleToFill
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let returnBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "return").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let logInTitle: UIImageView = {
        let title = UIImageView()
        title.image = #imageLiteral(resourceName: "Mystical Access")
        title.contentMode = .scaleAspectFit
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let separator: UIView = {
        let line = UIView()
//        line.backgroundColor = UIColor(netHex: 0xE9E9E9)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    let nameField: UITextField = {
        let name = UITextField()
        name.backgroundColor = .white
        name.placeholder = "Name"
        name.textAlignment = .center
        name.layer.cornerRadius = 5
        name.layer.borderWidth = 2
//        name.layer.borderColor =  UIColor(netHex: 0x756DEB).cgColor
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let emailField: UITextField = {
        let email = UITextField()
        email.backgroundColor = .white
        email.placeholder = "Email"
        email.textAlignment = .center
        email.layer.cornerRadius = 5
        email.layer.borderWidth = 2
//        email.layer.borderColor =  UIColor(netHex: 0x756DEB).cgColor
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let passField: UITextField = {
        let pass = UITextField()
        pass.backgroundColor = .white
        pass.placeholder = "Password"
        pass.textAlignment = .center
        pass.layer.cornerRadius = 5
        pass.isSecureTextEntry = true
        pass.layer.borderWidth = 2
//        pass.layer.borderColor =  UIColor(netHex: 0x756DEB).cgColor
        pass.translatesAutoresizingMaskIntoConstraints = false
        return pass
    }()
    
    let accesBtn: UIButton = {
        
        let btn = UIButton(type: .system)
//        btn.backgroundColor = UIColor(netHex: 0xFF5353)
        btn.setTitle("GET STARTED", for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    let applyBtn: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setTitle("APPLY", for: .normal)
        btn.addTarget(self, action: #selector(handleApply), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        setupViewBg()
        setupTextFieldsBtn()
    }
    
    @objc func handleDismiss(){
        self.dismiss(animated: true, completion: nil)
        

        print("dismiss")
    }
    
    @objc func handleApply(){
        print("Apply action")
    }

    @objc func getStarted() {
        guard let name = nameField.text, let email = emailField.text, let pass = passField.text else { return }
        createAccount(email: email, pass: pass, name: name)
    }
    
    
    func createAccount(email: String, pass: String, name: String){
        if let email = emailField.text, let pass = passField.text, let name = nameField.text{
            //validation email
            let isValid = isValidEmail(email: email)
            
            if isValid == true{
                //Creating account
                Auth.auth().createUser(withEmail: email, password: pass) { (user, error) in
                    if error != nil{
                        print("error: creating account")
                        return
                    }
                    
                    //success creating account
                    print("succes creating the account")
                    let data = [name: name,email: email]
                    let id = user?.uid
                    
                    self.ds.createFirebaseDBUser(uid: id!, userData: data)
                    
                    let destination = TabBar()
                    let appDelegate:UIApplicationDelegate = UIApplication.shared.delegate!
                    let initialViewController = destination
                    let navigationController = UINavigationController(rootViewController: initialViewController)
                    appDelegate.window??.rootViewController = navigationController
                    appDelegate.window??.makeKeyAndVisible()
                }
                
                
            }else{
                print("error: The format of your email is not valid")
            }
            
        }else{
            print("error login in")
        }
    }
    
    func siginUser(email: String, pass:String, name: String){
     
        Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, error) in
            
            
            
            if error != nil{
                print("error Authentication with email failed")
                return
            }
            
            self.data = [email: email, name: name]
            guard let id = user?.uid else {return}
            
            self.ds.createFirebaseDBUser(uid: id, userData: self.data)
            print("succes creating the account")
            self.view.endEditing(true)
            let destination = TabBar()
            let appDelegate:UIApplicationDelegate = UIApplication.shared.delegate!
            let initialViewController = destination
            let navigationController = UINavigationController(rootViewController: initialViewController)
            appDelegate.window??.rootViewController = navigationController
            appDelegate.window??.makeKeyAndVisible()
        })
    }
    
    //emailValidation
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }

    func setupViewBg(){
        view.addSubview(bg)
        bg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bg.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        bg.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        bg.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        view.addSubview(logInTitle)
        logInTitle.topAnchor.constraint(equalTo: bg.topAnchor, constant: 35).isActive = true
        logInTitle.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        logInTitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logInTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(separator)
        separator.topAnchor.constraint(equalTo: logInTitle.bottomAnchor, constant: 8).isActive = true
        separator.centerXAnchor.constraint(equalTo: logInTitle.centerXAnchor).isActive = true
        separator.widthAnchor.constraint(equalTo: bg.widthAnchor, constant: -10).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
       
        view.addSubview(returnBtn)
        returnBtn.centerYAnchor.constraint(equalTo: logInTitle.centerYAnchor).isActive = true
        returnBtn.leftAnchor.constraint(equalTo: bg.leftAnchor, constant: 15).isActive = true
        returnBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
        returnBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupTextFieldsBtn(){
        view.addSubview(passField)
        passField.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        passField.centerYAnchor.constraint(equalTo: bg.centerYAnchor).isActive = true
        passField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        passField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(emailField)
        
        emailField.bottomAnchor.constraint(equalTo: passField.topAnchor, constant: -10).isActive = true
        emailField.centerXAnchor.constraint(equalTo: passField.centerXAnchor).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(accesBtn)
        accesBtn.topAnchor.constraint(equalTo: passField.bottomAnchor, constant: 10).isActive = true
        accesBtn.centerXAnchor.constraint(equalTo: passField.centerXAnchor).isActive = true
        accesBtn.widthAnchor.constraint(equalToConstant: 300).isActive = true
        accesBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(applyBtn)
        applyBtn.topAnchor.constraint(equalTo: accesBtn.bottomAnchor).isActive = true
        applyBtn.centerXAnchor.constraint(equalTo: accesBtn.centerXAnchor).isActive = true
        applyBtn.widthAnchor.constraint(equalTo: accesBtn.widthAnchor).isActive = true
        applyBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameField)
        nameField.bottomAnchor.constraint(equalTo: emailField.topAnchor, constant: -8).isActive = true
        nameField.centerXAnchor.constraint(equalTo: passField.centerXAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: passField.widthAnchor).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}



































