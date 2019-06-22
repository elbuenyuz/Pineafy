//
//  signInVC.swift
//  Pineafy
//
//  Created by Juan Meza on 6/17/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import UIKit
import Firebase

class signInVC: UIViewController {
    

    let phoneTextField: UITextField = {
        
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.addShadow()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.layer.cornerRadius = 5
        textField.placeholder = "Phone Number "
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        
        let textField = UITextField()
        textField.textAlignment = .center
        textField.backgroundColor = .white
        textField.addShadow()
        textField.layer.cornerRadius = 5
        textField.autocapitalizationType = .none
        textField.keyboardType = UIKeyboardType.emailAddress
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    let phoneTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "JosefinSlab-SemiBold", size: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone number"
        return label
    }()
    
    let emailTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "JosefinSlab-SemiBold", size: 25)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        return label
    }()
    
    let getStartedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("GET STARTED", for: [])
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitle("SIGN UP WITH FACEBOOK", for: [])
        return button
    }()
    
    let termsLabel: UILabel = {
        let label = UILabel()
        label.text = "By sign up for Pineafy, you agree to our"
        label.font = UIFont(name: "JosefinSlab-SemiBold", size: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let termsLabel2: UILabel = {
        let label = UILabel()
        label.text = "and"
        label.font = UIFont(name: "JosefinSlab-SemiBold", size: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let termsActionLabel: UILabel = {
        let label = UILabel()
        label.text = "Terms of Use"
        label.font = UIFont(name: "JosefinSlab-SemiBold", size: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let privacyPolicyActionLabel: UILabel = {
        let label = UILabel()
        label.text = "Privacy Policy"
        label.font = UIFont(name: "JosefinSlab-SemiBold", size: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
//        navigationItem.titleView?.backgroundColor = .white
        setupInputsContainerView()
    }
    
    
    
    func setupInputsContainerView() {
        
        view.addSubview(phoneTitle)
        view.addSubview(phoneTextField)
        view.addSubview(emailTitle)
        view.addSubview(emailTextField)
        view.addSubview(getStartedButton)
        view.addSubview(facebookButton)
        view.addSubview(termsLabel)
        view.addSubview(termsActionLabel)
        view.addSubview(termsLabel2)
        view.addSubview(privacyPolicyActionLabel)
        
        phoneTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        phoneTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        phoneTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        phoneTitle.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        phoneTextField.topAnchor.constraint(equalTo: phoneTitle.bottomAnchor, constant: 8).isActive = true
        phoneTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        phoneTextField.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        emailTitle.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16).isActive = true
        emailTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        emailTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        emailTitle.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: 8).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        getStartedButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        getStartedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        getStartedButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        getStartedButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        facebookButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        facebookButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        facebookButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        termsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        termsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        termsActionLabel.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 4).isActive = true
        termsActionLabel.centerXAnchor.constraintGreaterThanOrEqualToSystemSpacingAfter(view.leftAnchor, multiplier: 3)
        
        termsLabel2.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 4).isActive = true
        termsLabel2.centerXAnchor.constraintGreaterThanOrEqualToSystemSpacingAfter(termsActionLabel.rightAnchor, multiplier: 3).isActive = true
        
        
        privacyPolicyActionLabel.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 4).isActive = true
        privacyPolicyActionLabel.centerXAnchor.constraintGreaterThanOrEqualToSystemSpacingAfter(termsLabel2.rightAnchor, multiplier: 3).isActive = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
