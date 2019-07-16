//
//  SignInVC+Handlers.swift
//  Pineafy
//
//  Created by Juan Meza on 6/21/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import Foundation
import UIKit
import Firebase


extension signInVC {
    
    @objc func handleRegister() {
        
        guard let phoneNumber = phoneTextField.text, let email = emailTextField.text else {
            return
        }
        
       
            
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID, forKey: "authVerificationID")
                }
                // Sign in using the verificationID and the code sent to the user
                // ...
            }
        
        
    
        
        
        if phoneNumber == "" && email == "" {
            
            print("Ambos campos deben de ester llenos")
        } else {
            
            //categoryVC
            print("Paso")
            /*PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
 
                // Sign in using the verificationID and the code sent to the user
                // ...
            }*/
            
            /*Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error) in
                
                if error != nil {
                    
                    print(error?.localizedDescription)
                    return
                }
            })*/
        }
    }
    
    
     @objc func handleCode() {
        
        print ("facebook")
        let defaults = UserDefaults.standard
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVerificationID")!, verificationCode: emailTextField.text!)
        
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                
                print("Phone number: \(user?.phoneNumber)")
                print("Phone number: \(user?.email)")
                //let userInfo = user?.providerData[0]
                //print("profile: \(userInfo?.email)")
            }
        }
        //let credential : PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: UserDefaults.string(forKey: "authVerificationID"), verificationCode: code.text!)
    }
    /*@objc func handledismissBlackView(){
        print("tap tap")
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            let heigth: CGFloat = 400
            if let window = UIApplication.shared.keyWindow{
                
                self.signInView.frame = CGRect(x: 0, y: (0 - window.frame.height) - 40, width: window.frame.width - 20, height: heigth)
               
            }
            
        }) { (completed: Bool) in
            
        }
    }*/
    
    @objc func handledismissBlackViewBlackView(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            //let heigth: CGFloat = CGFloat(self.settings.count) * self.cellHeight
            if let window = UIApplication.shared.keyWindow{
                
              //  self.collectionV.frame = CGRect(x: window.frame.width/2 - self.collectionV.frame.width/2, y:  0 - self.collectionV.frame.height, width: window.frame.width - 40, height: heigth)
                
            }
            
        }) { (completed: Bool) in
            
            
        }
    }
}
