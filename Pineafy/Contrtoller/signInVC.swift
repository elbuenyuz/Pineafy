//
//  signInVC.swift
//  Pineafy
//
//  Created by Juan Meza on 6/17/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import UIKit
import Firebase

class signInVC: UIView {
    
    let blackView = UIView()
    //var categoryVC: CategoryVC
    
    
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
        button.addTarget(self, action: #selector(handleCode), for: .touchUpInside)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        //view.backgroundColor = .white
        //navigationController?.navigationBar.barTintColor = .white
//        navigationItem.titleView?.backgroundColor = .white
        setupInputsContainerView()
        //showSettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*func showSettings(){
        print ("Entro")
        
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handledimissBlackView)))
            
            window.addSubview(blackView)
           // window.addSubview(background)
            
            //collectionV
            //let heigth: CGFloat = CGFloat(settings.count) * cellHeight
            
            //modificar posicion inicial de la colleccion
            //background.frame = CGRect(x: 0, y: (0 - window.frame.height) - 40, width: window.frame.width - 40, height: 200)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            //animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                //self.collectionV.frame = CGRect(x: window.frame.width/2 - self.collectionV.frame.width/2, y: 70, width: self.collectionV.frame.width, height: self.collectionV.frame.height)
                
            }, completion: nil)
        }
    }
    
    @objc func handledimissBlackView() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            /*let heigth: CGFloat = CGFloat(self.settings.count) * self.cellHeight
             if let window = UIApplication.shared.keyWindow{
             
             self.collectionV.frame = CGRect(x: window.frame.width/2 - self.collectionV.frame.width/2, y:  0 - self.collectionV.frame.height, width: window.frame.width - 40, height: heigth)
             
             }*/
            
        }) { (completed: Bool) in
            
            
        }
    }*/
    
    /*
    @objc func handledismissBlackViewBlackView(){
        print("entro")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            /*let heigth: CGFloat = CGFloat(self.settings.count) * self.cellHeight
            if let window = UIApplication.shared.keyWindow{
                
                self.collectionV.frame = CGRect(x: window.frame.width/2 - self.collectionV.frame.width/2, y:  0 - self.collectionV.frame.height, width: window.frame.width - 40, height: heigth)
                
            }*/
            
        }) { (completed: Bool) in
            
            
        }
    }*/
    
    
    func setupInputsContainerView() {
        
        self.addSubview(phoneTitle)
        self.addSubview(phoneTextField)
        self.addSubview(emailTitle)
        self.addSubview(emailTextField)
        self.addSubview(getStartedButton)
        self.addSubview(facebookButton)
        /*self.addSubview(termsLabel)
        self.addSubview(termsActionLabel)
        self.addSubview(termsLabel2)
        self.addSubview(privacyPolicyActionLabel)*/
        
        phoneTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 150).isActive = true
        phoneTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        phoneTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        phoneTitle.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        phoneTextField.topAnchor.constraint(equalTo: phoneTitle.bottomAnchor, constant: 8).isActive = true
        phoneTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        phoneTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        phoneTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailTitle.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16).isActive = true
        emailTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        emailTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        emailTitle.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: 8).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        getStartedButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        getStartedButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        getStartedButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        getStartedButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        facebookButton.bottomAnchor.constraint(equalTo: getStartedButton.bottomAnchor, constant: 30).isActive = true
        facebookButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        facebookButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        /*
        
        termsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80).isActive = true
        termsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        termsActionLabel.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 4).isActive = true
        termsActionLabel.centerXAnchor.constraintGreaterThanOrEqualToSystemSpacingAfter(self.leftAnchor, multiplier: 3)
        
        termsLabel2.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 4).isActive = true
        termsLabel2.centerXAnchor.constraintGreaterThanOrEqualToSystemSpacingAfter(termsActionLabel.rightAnchor, multiplier: 3).isActive = true
        
        
        privacyPolicyActionLabel.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 4).isActive = true
        privacyPolicyActionLabel.centerXAnchor.constraintGreaterThanOrEqualToSystemSpacingAfter(termsLabel2.rightAnchor, multiplier: 3).isActive = true*/
    }
    
   

}
