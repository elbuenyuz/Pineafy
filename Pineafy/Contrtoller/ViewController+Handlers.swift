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

extension ViewController {
    //Show horoscope friend View
    func showFriendhoroscope(){
        print("sending view friendHorosocope")
        if let window = UIApplication.shared.keyWindow{
            presentBlackScreen()
            window.addSubview(friendHorosocope)
            
            let heigth: CGFloat = window.frame.height - 100
            let width: CGFloat = window.frame.width - 25
            //modificar posicion inicial de la colleccion
            self.friendHorosocope.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.isUserInteractionEnabled = true
                self.blackView.alpha = 1
                self.friendHorosocope.frame = CGRect(x: window.frame.width/2 - width/2, y: window.frame.height - heigth + 20, width: width, height: self.friendHorosocope.frame.height - 80)
                
            }, completion: nil)
        }
    }
    //SHow pickerview View
    @objc func showPickerView(){
        if let window = UIApplication.shared.keyWindow{
            presentBlackScreen()
            //
            blackView.isUserInteractionEnabled = false
            window.addSubview(datePickerView)
            self.blackView.isUserInteractionEnabled = false
            let heigth: CGFloat = window.frame.height/2
            let width: CGFloat = window.frame.width - 50
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
        let user: BaseUserModel = notification.object as! BaseUserModel
        guard let bdate = user.bDate else {return}
        let scopeUser = asignHoroscope(date: bdate)
        
        
        for x in arrayHoroscopes{
            if scopeUser == x.sign{
                DispatchQueue.main.async {
                    self.updateView(horoscope: x)
                    self.collectionview.reloadData()
//                    guard let algo = UserDefaults.standard.value(forKey: "id") as? [HoroscopeModel] else {return print("BIG ERROR")}
              
                }
            }else{
               
            }
        }
        //save locally the user for post DB
    }
    @objc func handleEmail(){
        self.sendEmail()
    }
    //Constrains setup View
    func setupView(){
        //Collection bottom
        view.addSubview(collectionview)
        collectionview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionview.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        //Description container
        view.addSubview(descriptionContainer)
        descriptionContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        descriptionContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        descriptionContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        descriptionContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        
        descriptionContainer.addSubview(headerContainer)
        headerContainer.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 20).isActive = true
        headerContainer.centerXAnchor.constraint(equalTo: descriptionContainer.centerXAnchor).isActive = true
        headerContainer.widthAnchor.constraint(equalTo: descriptionContainer.widthAnchor).isActive = true
        headerContainer.heightAnchor.constraint(equalToConstant: 81).isActive = true
        
        //header Title and Date
        headerContainer.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: headerContainer.topAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: descriptionContainer.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        headerContainer.addSubview(dateLabel)
        dateLabel.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descriptionContainer.addSubview(horoscopeInfo)
        horoscopeInfo.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant:20).isActive = true
        horoscopeInfo.centerXAnchor.constraint(equalTo: descriptionContainer.centerXAnchor).isActive = true
        horoscopeInfo.widthAnchor.constraint(equalTo: descriptionContainer.widthAnchor,constant: -12).isActive = true
        horoscopeInfo.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        descriptionContainer.addSubview(actionContainer)
        actionContainer.topAnchor.constraint(equalTo: horoscopeInfo.bottomAnchor, constant: 30).isActive = true
        actionContainer.leadingAnchor.constraint(equalTo: horoscopeInfo.leadingAnchor).isActive = true
        actionContainer.widthAnchor.constraint(equalTo: horoscopeInfo.widthAnchor).isActive = true
        actionContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        actionContainer.addSubview(iconShare)
        iconShare.backgroundColor = .black
        iconShare.topAnchor.constraint(equalTo: actionContainer.topAnchor).isActive = true
        iconShare.centerXAnchor.constraint(equalTo: actionContainer.centerXAnchor).isActive = true
        iconShare.widthAnchor.constraint(equalToConstant: 1).isActive = true
        iconShare.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        actionContainer.addSubview(iconMessage)
        iconMessage.topAnchor.constraint(equalTo: actionContainer.topAnchor).isActive = true
        iconMessage.centerXAnchor.constraint(equalTo: actionContainer.centerXAnchor,constant:-80).isActive = true
        iconMessage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconMessage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        actionContainer.addSubview(iconGood)
        iconGood.topAnchor.constraint(equalTo: actionContainer.topAnchor).isActive = true
        iconGood.centerXAnchor.constraint(equalTo: actionContainer.centerXAnchor,constant:80).isActive = true
        iconGood.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iconGood.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 50).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    //Function used when we show a popup to the view
    func presentBlackScreen(){
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
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
            return #imageLiteral(resourceName: "Sagittarius")
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
