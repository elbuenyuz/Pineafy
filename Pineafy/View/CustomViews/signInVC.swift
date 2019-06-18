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
        textView.isScrollEnabled = false
        return textView
    }()
    
    let emailTextView: UITextView = {
        
        let textView = UITextView()
        textView.isScrollEnabled = false
        return textView
    }()
    
    let phoneTitle: UILabel = {
        let label = UILabel()
        label.text = "Phone number"
        return label
    }()
    
    let emailTitle: UILabel = {
        let label = UILabel()
        label.text = "Email"
        return label
    }()
    
    let getStartedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        button.setTitle("GET STARTED", for: [])
        return button
    }()
    
    let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blue
        button.setTitle("SIGN UP WITH FACEBOOK", for: [])
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
