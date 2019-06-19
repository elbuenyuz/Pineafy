//
//  signInVC.swift
//  Pineafy
//
//  Created by Juan Meza on 6/17/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import UIKit

class signInVC: UIViewController {
    
    let phoneTextView: UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let emailTextView: UITextView = {
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let phoneTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone number"
        return label
    }()
    
    let emailTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        return label
    }()
    
    let getStartedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GET STARTED", for: [])
        return button
    }()
    
    let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false 
        button.setTitle("SIGN UP WITH FACEBOOK", for: [])
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInputsContainerView()
    }
    
    
    
    func setupInputsContainerView() {
        
        phoneTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        phoneTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        phoneTitle.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        phoneTextView.topAnchor.constraint(equalTo: phoneTitle.bottomAnchor, constant: 8).isActive = true
        phoneTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        phoneTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        phoneTextView.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        emailTitle.topAnchor.constraint(equalTo: phoneTextView.bottomAnchor, constant: 16).isActive = true
        emailTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        emailTitle.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        emailTextView.topAnchor.constraint(equalTo: emailTitle.bottomAnchor, constant: 8).isActive = true
        emailTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        emailTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        emailTextView.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        getStartedButton.topAnchor.constraint(equalTo: emailTextView.bottomAnchor, constant: 20).isActive = true
        getStartedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        getStartedButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        getStartedButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        facebookButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30).isActive = true
        facebookButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        facebookButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        
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
