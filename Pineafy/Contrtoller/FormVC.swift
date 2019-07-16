//
//  FormVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 2/9/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import UIKit
import Stripe
import FirebaseDatabase


class FormVC: UIViewController {
    var homeController: ViewController?
    var dataService: DataService?
    var ref: DatabaseReference!
    
    let textfieldContainer: UIView = {
        let contain = UIView()
        contain.backgroundColor = .clear
        contain.translatesAutoresizingMaskIntoConstraints = false
        return contain
    }()
	
    let scrollView: UIImageView = {
       let scroll = UIImageView()
//        scroll.image = #imageLiteral(resourceName: "bgEmpty")
        scroll.contentMode = .scaleAspectFill
        scroll.backgroundColor = .white
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
	
	let containerInfo: UIView = {
		let vc = UIView()
		vc.backgroundColor = .red
		vc.translatesAutoresizingMaskIntoConstraints = false
		return vc
	}()
	
    let labelDesc: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "JosefinSlab-SemiBold", size: 25)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 6
        titleLabel.text = "Book unique readings and experiences."
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let registerBtn: UIButton = {
       let btn = UIButton(type: .system)
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 5
        btn.addShadowText()
        btn.addTarget(self, action: #selector(hanldeBtnAction), for: .touchUpInside)
        btn.backgroundColor = UIColor(red:1.00, green:0.11, blue:0.00, alpha:1.0)
        btn.titleLabel?.textAlignment = .center
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let labelWhite: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont(name: "JosefinSlab-SemiBold", size: 18)
        titleLabel.textColor = UIColor(red:0.89, green:0.44, blue:0.44, alpha:1.0)
        titleLabel.numberOfLines = 3
        titleLabel.textAlignment = .center
        titleLabel.text = "Register and obtain 25% OFF booking your first Reading"
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let phoneTextfield: UITextField = {
        let phone = UITextField()
        phone.textAlignment = .center
        phone.backgroundColor = .white
        phone.addShadow()
        phone.layer.cornerRadius = 5
        phone.placeholder = "Mobile phone"
        phone.translatesAutoresizingMaskIntoConstraints = false
        return phone
    }()
    
    let mailTextfield: UITextField = {
        let mail = UITextField()
        mail.textAlignment = .center
        mail.backgroundColor = .white
        mail.autocapitalizationType = .none
        mail.addShadow()
        mail.layer.cornerRadius = 5
        mail.placeholder = "Email"
        mail.translatesAutoresizingMaskIntoConstraints = false
        return mail
    }()
    
    let nameField: UITextField = {
        let mail = UITextField()
        mail.textAlignment = .center
        mail.backgroundColor = .white
        mail.addShadow()
        mail.layer.cornerRadius = 5
        mail.placeholder = "Name"
        mail.translatesAutoresizingMaskIntoConstraints = false
        return mail
    }()
    
    let line: UIView = {
        let l = UIView()
        l.backgroundColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let containerForm: UIView = {
       let cv = UIView()
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let titleImg : UIImageView = {
        var img = UIImageView()
        img.contentMode = .scaleToFill
        img.image = #imageLiteral(resourceName: "pinefyAstrologers")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.15, green:0.60, blue:0.97, alpha:1.0)
        self.navigationController?.view.backgroundColor = .clear
        
        self.nameField.delegate = self
        self.mailTextfield.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardDidShow, object: nil)
        
        view.backgroundColor = .red
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func hanldeBtnAction(){
       
        
        if let email = mailTextfield.text, mailTextfield.text != "", let name = nameField.text, nameField.text != "", let phone = phoneTextfield.text, phoneTextfield.text != "" {
            print("\(email)")
            print("\(name)")
            print("\(phone)")
            
            print("action")
            createSpinnerView()
            //save info Database
            ref = Database.database().reference().child("users").childByAutoId()
            
            guard let sign = UserDefaults.standard.string(forKey: KEY_USER_SIGN),let date = UserDefaults.standard.string(forKey: KEY_USER_DATE) else {return}
                
                ref.setValue([email,name,phone,sign,date]) { (error, DatabaseReference) in
                    UserDefaults.standard.set("\(email)", forKey: KEY_EMAIL_USER)
                    UserDefaults.standard.set("\(name)", forKey: KEY_NAME_USER)
                    UserDefaults.standard.set("\(phone)", forKey: KEY_PHONE_USER)
                }
            
            self.displayAlertSuccess(name: name)
        }else{
            print("handle error")
            self.alertErrorEmptyTextfield()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.hideKeyboardWhenTappedAround()
       
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = (keyboardSize.height) + 20
            print(keyboardHeight)
            self.bottomAnchor?.isActive = false
            bottomKeyboard = textfieldContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardHeight )
            self.bottomKeyboard?.isActive = true
            
            
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
               self.textfieldContainer.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.bottomAnchor?.isActive = true
        self.bottomKeyboard?.isActive = false
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.textfieldContainer.layoutIfNeeded()
        }, completion: nil)
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()
        
        // add the spinner view controller
        addChildViewController(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
        
        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
            
        }
    }
//
//    func handleAddPaymentMethodButtonTapped() {
//        // Setup add card view controller
//        let addCardViewController = STPAddCardViewController()
//        addCardViewController.delegate = self as? STPAddCardViewControllerDelegate
//
//        // Present add card view controller
//        let navigationController = UINavigationController(rootViewController: addCardViewController)
//        present(navigationController, animated: true)
//    }
    
    var bottomAnchor: NSLayoutConstraint?
    var bottomKeyboard: NSLayoutConstraint?
    
    func setupView(){
        
//        let layer = CAGradientLayer()
//        layer.frame = view.bounds
//        layer.colors = [UIColor.white.cgColor,UIColor(red:0.56, green:0.00, blue:0.44, alpha:1.0).cgColor]
//        layer.startPoint = CGPoint(x: 0.5, y: 0)
//        layer.endPoint = CGPoint(x: 0.5, y: 1)
//        view.layer.addSublayer(layer)
		
		
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        scrollView.addSubview(titleImg)
        titleImg.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        titleImg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleImg.widthAnchor.constraint(equalToConstant: 296).isActive = true
        titleImg.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        scrollView.addSubview(labelDesc)
        labelDesc.topAnchor.constraint(equalTo: self.titleImg.bottomAnchor, constant: 0).isActive = true
        labelDesc.centerXAnchor.constraint(equalTo: self.titleImg.centerXAnchor).isActive = true
        labelDesc.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50).isActive = true
        labelDesc.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //form
        view.addSubview(containerForm)
        containerForm.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        containerForm.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        containerForm.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        containerForm.heightAnchor.constraint(equalToConstant: 275).isActive = true
        
        containerForm.addSubview(registerBtn)
        registerBtn.bottomAnchor.constraint(equalTo: self.containerForm.bottomAnchor, constant: -10).isActive = true
        registerBtn.leadingAnchor.constraint(equalTo: self.labelDesc.leadingAnchor).isActive = true
        registerBtn.trailingAnchor.constraint(equalTo: self.labelDesc.trailingAnchor).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        containerForm.addSubview(line)
        line.bottomAnchor.constraint(equalTo: registerBtn.topAnchor, constant: -20).isActive = true
        line.leadingAnchor.constraint(equalTo: labelDesc.leadingAnchor, constant: 40).isActive = true
        line.trailingAnchor.constraint(equalTo: labelDesc.trailingAnchor, constant: -40 ).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        containerForm.addSubview(labelWhite)
        labelWhite.bottomAnchor.constraint(equalTo: self.line.topAnchor, constant: -20).isActive = true
        labelWhite.leadingAnchor.constraint(equalTo: self.labelDesc.leadingAnchor, constant: 20).isActive = true
        labelWhite.trailingAnchor.constraint(equalTo: self.labelDesc.trailingAnchor, constant: -20).isActive = true
        labelWhite.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(textfieldContainer)
        
        bottomAnchor = textfieldContainer.bottomAnchor.constraint(equalTo: self.labelWhite.topAnchor, constant: -20)
        bottomKeyboard = textfieldContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -340)
        
        bottomAnchor?.isActive = true
        
//        textfieldContainer.bottomAnchor.constraint(equalTo: self.labelWhite.topAnchor, constant: -15).isActive = true
        textfieldContainer.leadingAnchor.constraint(equalTo: self.labelDesc.leadingAnchor).isActive = true
        textfieldContainer.trailingAnchor.constraint(equalTo: self.labelDesc.trailingAnchor).isActive = true
        textfieldContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        textfieldContainer.addSubview(nameField)
        nameField.bottomAnchor.constraint(equalTo: self.textfieldContainer.bottomAnchor).isActive = true
        nameField.leadingAnchor.constraint(equalTo: self.textfieldContainer.leadingAnchor).isActive = true
        nameField.trailingAnchor.constraint(equalTo: self.textfieldContainer.trailingAnchor).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
        
        textfieldContainer.addSubview(mailTextfield)
        mailTextfield.bottomAnchor.constraint(equalTo: self.nameField.topAnchor, constant: -10).isActive = true
        mailTextfield.leadingAnchor.constraint(equalTo: nameField.leadingAnchor).isActive = true
        mailTextfield.trailingAnchor.constraint(equalTo: nameField.trailingAnchor).isActive = true
        mailTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textfieldContainer.addSubview(phoneTextfield)
        phoneTextfield.bottomAnchor.constraint(equalTo: self.mailTextfield.topAnchor, constant: -10).isActive = true
        phoneTextfield.leadingAnchor.constraint(equalTo: mailTextfield.leadingAnchor).isActive = true
        phoneTextfield.trailingAnchor.constraint(equalTo: mailTextfield.trailingAnchor).isActive = true
        phoneTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
    }
    
    func displayAlert(){
        let alert = UIAlertController(title: "Hello and Thanks", message: "we will send how can you all the resources you need to get your first reading.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { (alert) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    func displayAlertSuccess(name: String){
        
        let alert = UIAlertController(title: "Hello \(name)", message: "we would send you an email with all the information to book your first reading.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: { (alert) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true)
        
    }
    
    func alertErrorEmptyTextfield(){
        
        let alert = UIAlertController(title: "Ups!", message: "Please check that you enter your information", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alert) in
            
        }))
        
        self.present(alert, animated: true)
        
    }
}




extension UIViewController: UITextFieldDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
