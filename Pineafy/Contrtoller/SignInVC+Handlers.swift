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
        
        if phoneNumber == "" && email == "" {
            
            print("Ambos campos deben de ester llenos")
        } else {
            
            /*Auth.auth().createUser(withEmail: email, password: password, completion: {(authResult, error) in
                
                if error != nil {
                    
                    print(error?.localizedDescription)
                    return
                }
            })*/
        }
    }
}
