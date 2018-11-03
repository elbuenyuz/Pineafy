
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

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate, MFMailComposeViewControllerDelegate{
    let blackView = UIView()
    var date: String = ""
    let IdCell = "cellId"
    let ID_ARRAY = "id"
    var resp:Bool = false
    

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
    
    
    
   lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isHidden = true
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
//    let descriptionContainer: UIScrollView = {
//        let view = UIScrollView()
//        view.backgroundColor = .purple
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    var arrayHoroscopes = [HoroscopeModel]()
    var nsarray: [Any] = []
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
//        view.backgroundColor = .magenta
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
        lbl.addShadowIcon()
        lbl.textColor = .lightGray
        lbl.font = UIFont(name: "JosefinSlab-ThinItalic", size: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let horoscopeInfo: UITextView = {
        let h = UITextView()
        h.font = UIFont(name: "JosefinSlab-Regular", size: 23)
//        h.backgroundColor = .orange
        h.textAlignment = .justified
        h.isUserInteractionEnabled = false
        h.addShadowIcon()
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
        parseUrl {
            
        }
//        presentWalkthrough()
        showPickerView()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        setupView()
        descriptionContainer.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        descriptionContainer.contentSize = CGSize(width: self.view.frame.width, height: 600)
        navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(showPickerView), name: Notification.Name.tabVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopupClosing), name: Notification.Name.bDate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hanldeSpinnerDownload), name: NSNotification.Name.hidden, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendShareHorosocope), name: NSNotification.Name.shareFriend, object: nil)
        collectionview.register(friendHoroscopeCell.self, forCellWithReuseIdentifier: IdCell)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
        
    }
    
    //Need to be fixed the way we handle sharing the information.
    @objc func handleFriendShareHorosocope(){
        self.shareAction()
    }

    
    func parseUrl(completed: @escaping DownloadComplete){
        
        guard let url = URL(string: "http://www.pineafy.com/backend/fetchScopes/2018-10-18/") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.arrayHoroscopes = []
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
                    var image = self.handleImage(key: key)
                    guard var model: HoroscopeModel = HoroscopeModel(json: object, image:image) else {return}
                    self.arrayHoroscopes.append(model)
                    self.nsarray.append(model)
                    print("name: \(model.sign)")
                    
                }
//                UserDefaults.standard.setValue(self.nsarray, forKey: "id")
                print("array saliendo: \(self.arrayHoroscopes.count)")
                print("array guardado: \(self.nsarray.count)")
                
                DispatchQueue.main.async {
                    self.collectionview.reloadData()
                    
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        completed()
    }

    func updateView(horoscope: HoroscopeModel){
        titleLabel.text = horoscope.sign?.uppercased()
        horoscopeInfo.text = horoscope.horoscope
        dateLabel.text = horoscope.date
        
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
//            //manage the download of the information and the views fetch!
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateStyle = DateFormatter.Style.short
//            dateFormatter.timeStyle = DateFormatter.Style.short
//            let strDate = dateFormatter.string(from: self.datePickerView.datePicker.date)
//            print("date::\(strDate)")
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
    

    
    func checkAndPresentForWalkthroug(){

        resp = UserDefaults.standard.bool(forKey: "completeWalk")
        
        switch resp {
        case true:
            print("usuario SI ha visto el walk \(resp)")
            
            
        case false:
            print("usuario NO ha visto el walk \(resp)")
            UserDefaults.standard.set(true, forKey: "completeWalk")
            presentWalkthrough()
        default:
            return
        }
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
    
    //CollectionViewControllers
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("nunmero de items:\(arrayHoroscopes.count)")
        return (arrayHoroscopes.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell, for: indexPath) as! friendHoroscopeCell
        cell.categories = self.arrayHoroscopes[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("isSelected \(print(arrayHoroscopes[indexPath.item]))")
        let model = arrayHoroscopes[indexPath.item]
        self.friendHorosocope.horoscope = model
        self.showFriendhoroscope()
    }
}

