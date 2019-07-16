//
//  ViewController+Handlers.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 10/21/18.
//  Copyright © 2018 Devius. All rights reserved.
//  Example func scapeDownload(completed: @escaping DownloadComplete)
//
//

import UIKit


extension ViewController{
    
    //SHow pickerview View
    @objc func showPickerView(){
        if let window = UIApplication.shared.keyWindow{
            presentBlackScreen()
            //
            window.addSubview(datePickerView)
            self.blackView.isUserInteractionEnabled = false
            let heigth: CGFloat = window.frame.height/2.1
            let width: CGFloat = window.frame.width - 40
            //modificar posicion inicial de la colleccion
            datePickerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.datePickerView.frame = CGRect(x: window.frame.width/2 - width/2, y: window.frame.height - heigth - 30, width: width, height: self.datePickerView.frame.height - 80)
                
            }, completion: nil)
        }
    }

    //function handle the popup closing after ask for BDate and transaction of information
    @objc func handlePopupClosing(notification: Notification){
        handledismissBlackView()
        
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
        
        let date = notification.object as! String
        let nameScopeUser = asignHoroscope(date: date)
    

        //save locally the user for post DB
        UserDefaults.standard.set(date, forKey: KEY_USER_DATE)
        UserDefaults.standard.set(nameScopeUser, forKey: KEY_USER_SIGN)
        UserDefaults.standard.synchronize()
        
        for x in arrayHoroscopes{
            if x.sign == nameScopeUser{
                navigationController?.navigationBar.topItem?.title = x.sign
                self.handleHidden()
                self.updateView(horoscope: x)
            }
        }
        collectionview.reloadData()
    }
    
    func updateView(horoscope: HoroscopeModel){
        
        titleLabel.text = horoscope.sign?.uppercased()
        horoscopeInfo.text = horoscope.horoscope
        dateLabel.text = horoscope.date
		zodiacSignImageView.image = horoscope.image
    }
    
    //    MARK: Persistant data

    @objc func handleEmail(scope: String, signName: String){
        self.sendEmail()
    }
 
    //Constrains setup View
    func setupView(){
		
		
        
        //Collection bottom
        view.addSubview(collectionview)
        collectionview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionview.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(friendLabel)
        friendLabel.bottomAnchor.constraint(equalTo: collectionview.topAnchor).isActive = true
        friendLabel.leadingAnchor.constraint(equalTo: collectionview.leadingAnchor, constant: 20).isActive = true
        friendLabel.widthAnchor.constraint(equalTo: collectionview.widthAnchor).isActive = true
        friendLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Description container
        view.addSubview(descriptionContainer)
        descriptionContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        descriptionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        descriptionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        descriptionContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
		
		view.addSubview(zodiacSignImageView)
		zodiacSignImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
		zodiacSignImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		zodiacSignImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
		zodiacSignImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: zodiacSignImageView.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        descriptionContainer.addSubview(horoscopeInfo)
//        horoscopeInfo.backgroundColor = .yellow
        horoscopeInfo.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        horoscopeInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        horoscopeInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        horoscopeInfo.bottomAnchor.constraint(equalTo: friendLabel.topAnchor).isActive = true
        
       
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 50).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    
    @objc func handleLogOut(){
        
//        UserDefaults.standard.removeObject(forKey: KEY_USER_DATE)
//        UserDefaults.standard.removeObject(forKey: KEY_NAME_USER)
//        UserDefaults.standard.removeObject(forKey: KEY_EMAIL_USER)
        
        
        hiddenInfo()
        navigationController?.navigationBar.topItem?.title = ""
        dateLabel.text = ""
        presentWalkthrough()
        return
    }
    
    func hiddenInfo(){
       
        self.descriptionContainer.isHidden = true
        self.actionContainer.isHidden = true
        self.headerContainer.isHidden = true
        self.horoscopeInfo.isHidden = true
        self.collectionview.isHidden = true
        self.friendLabel.isHidden = true
        self.dateLabel.isHidden = true
    }
    
    //Function used when we show a popup to the view
    func presentBlackScreen(){
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.9)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handledismissBlackView)))
        
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(blackView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
        }
    }
    
    //Handle Hidden of the items, we asign the value to them before we show them to the user
    @objc func handleHidden(){
        self.descriptionContainer.isHidden = false
        self.actionContainer.isHidden = false
        self.headerContainer.isHidden = false
        self.horoscopeInfo.isHidden = false
        self.collectionview.isHidden = false
        self.friendLabel.isHidden = false
        self.dateLabel.isHidden = false
    }
    
    //Handle adding a image to the horoscopes
    func handleImage(key: String) -> UIImage{
        //logic received a key and return the image that correspond to the array.
        print("key: \(key)")
        switch key {
        case "Gemini":
            return #imageLiteral(resourceName: " Gemini")
        case "Aries":
            return  #imageLiteral(resourceName: " Aries")
        case "Aquarius":
            return  #imageLiteral(resourceName: " Aquarius")
        case "Leo":
            return  #imageLiteral(resourceName: " Leo")
        case "Scorpio":
            return  #imageLiteral(resourceName: " Scorpio")
        case "Virgo":
            return  #imageLiteral(resourceName: " Virgo")
        case "Cancer":
            return  #imageLiteral(resourceName: " Cancer")
        case "Pisces":
            return  #imageLiteral(resourceName: " Pisces")
        case "Capricorn":
            return #imageLiteral(resourceName: " Capricorn")
        case "Libra":
            return #imageLiteral(resourceName: " Libra")
        case "Sagittarius":
            return #imageLiteral(resourceName: "Sagittarius")
        case "Taurus":
            return  #imageLiteral(resourceName: " Taurus")
            
        default:
            return UIImage()
        }
    }
    func handleAccount(){
        self.navigationController?.pushViewController(AccountVC(), animated: true)
    }
    
    //received a date and return a name of the horoscope selected
    func asignHoroscope(date: String) -> String{
        //asign horoscope to the user
        print("deciding which sign are you!")
        var response = ""
        let parts = date.components(separatedBy: "-")
        let year = parts[0]
        var day = parts[2]
        let month = parts[1]
        
        
        if let nday = Int(day){
            print("Month: \(month)")
            switch month {
            case "01":
                if nday >= 21 {
                    response = "Aquarius"
                }else{
                    response = "Capricorn"
                }
            case "02":
                if nday >= 19 {
                    response = "Pisces"
                }else{
                    response = "Aquarius"
                }
            case "03":
                if nday >= 21 {
                    response = "Aries"
                }else{
                    response = "Pisces"
                }
            case "04":
                if nday >= 21 {
                    response = "Taurus"
                }else{
                    response = "Aries"
                }
            case "05":
                if nday >= 22 {
                    response = "Gemini"
                }else{
                    response = "Taurus"
                }
            case "06":
                if nday >= 22 {
                    response = "Cancer"
                }else{
                    response = "Gemini"
                }
            case "07":
                if nday >= 23 {
                    response = "Leo"
                }else{
                    response = "Cancer"
                }
            case "08":
                if nday >= 23 {
                    response = "Virgo"
                }else{
                    response = "Leo"
                }
            case "09":
                if nday >= 24 {
                    response = "Libra"
                }else{
                    response = "Virgo"
                }
            case "10":
                if nday >= 24 {
                    response = "Scorpio"
                }else{
                    response = "Libra"
                }
            case "11":
                if nday >= 23 {
                    response = "Sagittarius"
                }else{
                    response = "Scorpio"
                }
            case "12":
                if nday >= 22 {
                    response = "Capricorn"
                }else{
                    response = "Sagittarius"
                }
            default:
                let error = "error"
                return error
            }
        }
        return response
    }
}
