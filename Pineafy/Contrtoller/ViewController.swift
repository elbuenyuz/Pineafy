
//  ViewController.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 9/24/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit
import Foundation
import MessageUI
import Alamofire

typealias DownloadComplete = () -> ()




let BASE_URL = "http://www.pineafy.com/backend/fetchScopes"

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout , MFMailComposeViewControllerDelegate{
    let blackView = UIView()
    var date: String = ""
    

    var spinner :UIActivityIndicatorView = {
        let spin = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

        spin.color = .lightGray
        spin.translatesAutoresizingMaskIntoConstraints = false
        return spin
    }()
    
    let datePickerView: DatePickerView = {
        let view = DatePickerView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let friendHorosocope: FriendHoroscopeView = {
        let view = FriendHoroscopeView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    
    
    let collectionview: FriendHorosocopeCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = FriendHorosocopeCollectionView()
        cv.isHidden = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .red
        return cv
    }()
    
//    let descriptionContainer: UIScrollView = {
//        let view = UIScrollView()
//        view.backgroundColor = .purple
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    var arrayHoroscopes = [HoroscopeModel]()
    
    lazy var descriptionContainer: UIScrollView = {
        let view = UIScrollView(frame: UIScreen.main.bounds)
//        view.backgroundColor = .purple
        view.showsVerticalScrollIndicator = false
        view.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let headerContainer: UIView = {
        let view = UIView()
//        view.backgroundColor = .blue
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel:UILabel = {
        let lbl = UILabel()
//        lbl.backgroundColor = .yellow
        lbl.text = "PISCES"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 30)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dateLabel:UILabel = {
        let lbl = UILabel()
//        lbl.backgroundColor = .yellow
        lbl.text = "09/25/2018"
        lbl.textAlignment = .center
        lbl.textColor = .lightGray
        lbl.font = UIFont(name: "JosefinSlab-ThinItalic", size: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let horoscopeInfo: UITextView = {
        let h = UITextView()
        h.font = UIFont(name: "JosefinSlab-Regular", size: 23)
//        h.backgroundColor = .orange
        h.textAlignment = .center
        h.isUserInteractionEnabled = true
        h.addShadow()
        h.isHidden = true
        h.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    let iconGood: UIButton = {
        let btn = UIButton(type: .system)
        btn.addShadow()
        btn.addTarget(self, action: #selector(shareAction), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "share").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let iconShare: UILabel = {
        let btn = UILabel()
        btn.text = "|"
        btn.contentMode = .center
        btn.textColor = .black
        btn.addShadow()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let iconMessage: UIButton = {
        let btn = UIButton(type: .system)
        btn.addShadow()
        btn.addTarget(self, action: #selector(handleEmail), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "message").withRenderingMode(UIImageRenderingMode.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let actionContainer: UIView = {
        let view = UIView()
        view.isHidden = true
//        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let friendLabel: UILabel = {
       let label = UILabel()
        label.text = "Friend's Horoscopes"
        label.font = UIFont(name: "JosefinSlab-Bold", size: 23)
        label.textColor = UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
        label.isHidden = true
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseUrl(url:"http://www.pineafy.com/backend/fetchScopes/2018-10-18/")
        
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        presentWalkthrough()
//        handleHidden()
        setupView()
//        updateView(horoscope: arrayHoroscopes[0])
        descriptionContainer.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        descriptionContainer.contentSize = CGSize(width: self.view.frame.width, height: 600)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(showSettings), name: Notification.Name.tabVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handledismissBlackView), name: Notification.Name.bDate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hanldeSpinnerDownload), name: NSNotification.Name.hidden, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendHoroscope), name: NSNotification.Name.friend, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendShareHorosocope), name: NSNotification.Name.shareFriend, object: nil)

        
    }

    
    @objc func handleFriendShareHorosocope(){
        self.shareAction()
    }

    @objc func handleFriendHoroscope(){
        self.friendHorosocope.horoscope = arrayHoroscopes[8]
        self.showFriendhoroscope()
        
        
    }
    
    let keyValues: [String] = ["Capricorn","Pisces","Taurus","Cancer","Aquarius","Stagittarius","Virgo","Gemini","Aries","Scorpio","Libra","Leo"]
    
//    func scapeDownload(completed: @escaping DownloadComplete){
//
//    }
    
    func parseUrl(url:String){
        self.arrayHoroscopes = []
        guard let url = URL(string: url) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                guard let array = jsonResponse as? [String: AnyObject] else {return}
                for (key,value) in array {
                    guard let object = value as? [String: Any] else {return}
                    guard var model: HoroscopeModel = HoroscopeModel(json: object) else {return}
                    self.arrayHoroscopes.append(model)
                    print("name: \(model.sign)")
                    
                }
                
                DispatchQueue.main.async {
                    self.updateView(horoscope: self.arrayHoroscopes[0])
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
            
        }
        task.resume()
        
    }
    
    func todayDate() -> String{
        let today = "2018-10-18"
        return today
    }
    
    //PresentBlackScreen
    func presentBlackScreen(){
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handledismissBlackView)))
        
        if let window = UIApplication.shared.keyWindow{
            window.addSubview(blackView)
            
            blackView.frame = window.frame
            blackView.alpha = 0
        }
    }
    private func updateView(horoscope: HoroscopeModel){
        titleLabel.text = horoscope.sign?.uppercased()
        horoscopeInfo.text = horoscope.horoscope
        dateLabel.text = horoscope.date
        
    }
    
    func setupView(){
        //Collection bottom
        view.addSubview(collectionview)
        collectionview.backgroundColor = .yellow
        collectionview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionview.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        collectionview.setupHoroscopes(array: arrayHoroscopes)
        

        //Description container
        view.addSubview(descriptionContainer)
        descriptionContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        descriptionContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        descriptionContainer.bottomAnchor.constraint(equalTo: collectionview.topAnchor).isActive = true
        
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
        horoscopeInfo.widthAnchor.constraint(equalTo: descriptionContainer.widthAnchor).isActive = true
        horoscopeInfo.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        descriptionContainer.addSubview(actionContainer)
        actionContainer.topAnchor.constraint(equalTo: horoscopeInfo.bottomAnchor, constant: 20).isActive = true
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
        
        view.addSubview(friendLabel)
        friendLabel.bottomAnchor.constraint(equalTo: collectionview.topAnchor).isActive = true
        friendLabel.leadingAnchor.constraint(equalTo: collectionview.leadingAnchor, constant: 10).isActive = true
        friendLabel.trailingAnchor.constraint(equalTo: collectionview.trailingAnchor).isActive = true
        friendLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        spinner.widthAnchor.constraint(equalToConstant: 50).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    //Show popup
    @objc func showSettings(){
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
    
    func showFriendhoroscope(){
        print("sending view friendHorosocope")
        if let window = UIApplication.shared.keyWindow{
            presentBlackScreen()
            window.addSubview(friendHorosocope)
            
            let heigth: CGFloat = window.frame.height - 50
            let width: CGFloat = window.frame.width
            //modificar posicion inicial de la colleccion
            self.friendHorosocope.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
            
            UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.isUserInteractionEnabled = true
                self.blackView.alpha = 1
                self.friendHorosocope.frame = CGRect(x: window.frame.width/2 - width/2, y: window.frame.height - heigth + 20, width: width, height: self.friendHorosocope.frame.height - 80)
                
            }, completion: nil)
        }
    }
    
   @objc func handleHidden(){
        self.descriptionContainer.isHidden = false
        self.actionContainer.isHidden = false
        self.headerContainer.isHidden = false
        self.horoscopeInfo.isHidden = false
        self.collectionview.isHidden = false
        self.friendLabel.isHidden = false
    }
    //Dismiss the black View oresented to show something
    @objc func handledismissBlackView(){
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            let heigth: CGFloat = 400
            if let window = UIApplication.shared.keyWindow{
                self.datePickerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
                self.friendHorosocope.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
            }
            
        }) { (completed: Bool) in
            //manage the download of the information and the views fetch!
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            let strDate = dateFormatter.string(from: self.datePickerView.datePicker.date)
            print("date::\(strDate)")
        }
    }
    //Present The walkthrough once cicle
    private func presentWalkthrough(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let myCollectionVC = SwipingController(collectionViewLayout: layout)
        blackView.isUserInteractionEnabled = true
        navigationController?.present(myCollectionVC, animated: true, completion: nil)
        
    }
    
    @objc func handleEmail(){
        self.sendEmail()
    }
    
    func sendEmail(){
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["info@pineafy.com"])
            mail.setSubject("Feedback")
            mail.setMessageBody("Everytime is a good time to share what you think!", isHTML: false)
            self.present(mail, animated: true, completion: nil)
        }else{
            print("error sending mail")
        }
    }
    //we check the result so we can dismiss the window
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
   @objc func shareAction(){
        print("share")
        let myWebsite = NSURL(string:"www.pineafy.com")
        let text = "Espresso Brown Classic Bristol Rose Gold Watch by Daniel Wellington features contrasting notches display. This classy watch is the perfect finishing touch to any ensemble Watch by Daniel Wellington features contrasting notches display. This classy watch is the perfect finishing touch. \(myWebsite!)"
        let image = #imageLiteral(resourceName: " Virgo")
    
        let shareAll: [Any] = [text,image]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    
    
    }
    
    @objc func hanldeSpinnerDownload(){
        
        UIView.animate(withDuration: 10, delay: 5.5, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .transitionCurlUp, animations: {
            self.spinner.startAnimating()
        }) { (false) in
            self.spinner.stopAnimating()
            self.handleHidden()
        }
        
    }
}

