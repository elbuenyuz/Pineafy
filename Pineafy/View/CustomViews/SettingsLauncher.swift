//
//  SettingsLauncher.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit
import MessageUI

//creamos la vista y mandamos llamar el contenedor de settings
class SettingsLauncher: NSObject ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate{
    
    var isLoggedIn: Bool = false
    var homeController: ViewController?
    let blackView = UIView()
    
    let collectionV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.borderColor = UIColor.lightGray.cgColor
        
        cv.isScrollEnabled = false
        cv.layer.cornerRadius = 5
        cv.backgroundColor = .white
        return cv
    }()
    
    //arraySettingsMenu
    var settings: [SettingMenuModel] = {
        
        //        Setting(name: "Logout", imgName: "log")
        return [SettingMenuModel(name: "Feedback", imgName: "rate"),SettingMenuModel(name: "Rate Us", imgName: "star"), SettingMenuModel(name: "Marketplace", imgName: "scope-logo"),SettingMenuModel(name: "Account", imgName: "account")]
    }()
    
    //se ejecutab al presionar el boton derecho
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    //send email
    func sendEmail(){
        if MFMailComposeViewController.canSendMail(){
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@pineafy.com"])
            mail.setMessageBody("<p>Thanks for helping us to improve, we would contact you soon.</p>", isHTML: true)
            
            self.homeController?.present(mail, animated: true, completion: nil)
        }else{
            print("error: sending email fail")
        }
    }
    //we check the result so we can dismiss the window
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func showSettings(){
        
        
        if let window = UIApplication.shared.keyWindow{
           
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handledismissBlackViewBlackView)))
            
            window.addSubview(blackView)
            window.addSubview(collectionV)
            
            //collectionV
           let heigth: CGFloat = CGFloat(settings.count) * cellHeight
            
            //modificar posicion inicial de la colleccion
            collectionV.frame = CGRect(x: 0, y: (0 - window.frame.height) - 40, width: window.frame.width - 40, height: heigth)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            //animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.collectionV.frame = CGRect(x: window.frame.width/2 - self.collectionV.frame.width/2, y: 70, width: self.collectionV.frame.width, height: self.collectionV.frame.height)
                
            }, completion: nil)
        }
    }
    
    func shareAction(){
        print("share")
        let activityVC = UIActivityViewController(activityItems: ["Hey check out this app and balance your daily mood today!"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.homeController?.view
        
        self.homeController?.present(activityVC, animated: true, completion: nil)
    }
    func feedbackAction(){
        self.sendEmail()
    }
    
    func rateAction(){
        let appDelegate = AppDelegate()
        appDelegate.requestReview()
        print("rate action")
    }
    
    func premiumAction(){
//        self.homeController?.checkIfUserIsLoggedIn()
        print("Premium access")
    }
    
    @objc func handledismissBlackViewBlackView(){
        print("entro")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            let heigth: CGFloat = CGFloat(self.settings.count) * self.cellHeight
            if let window = UIApplication.shared.keyWindow{
                
                self.collectionV.frame = CGRect(x: window.frame.width/2 - self.collectionV.frame.width/2, y:  0 - self.collectionV.frame.height, width: window.frame.width - 40, height: heigth)
                
            }
            
        }) { (completed: Bool) in
            
    
        }
    }
    @objc func handledismissBlackView(setting: SettingMenuModel){
        
        print("menu de todo")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            let heigth: CGFloat = CGFloat(self.settings.count) * self.cellHeight
            if let window = UIApplication.shared.keyWindow{
                
                self.collectionV.frame = CGRect(x: window.frame.width/2 - self.collectionV.frame.width/2, y:  0 - self.collectionV.frame.height, width: window.frame.width - 40, height: heigth)
                
            }
            
        }) { (completed: Bool) in
            
            switch setting.name {
            case "Account":
                 self.homeController?.handleAccount()
//                self.homeController?.showPickerView()
            case "Share":
                self.shareAction()
            case "Feedback":
                self.feedbackAction()
            case "Rate Us":
                self.rateAction()
            case "Marketplace":
				self.homeController?.navigationController?.pushViewController(CategoryVC(), animated: true)
            case "":
                print("no es nada")
            default:
                break
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionV.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        cell.backgroundColor = .white
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handledismissBlackView(setting: setting)
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionV.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1
    }
    
    override  init() {
        super.init()
        // start doing here maybe
        collectionV.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        collectionV.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
        collectionV.dataSource = self
        collectionV.delegate = self
    }
}











