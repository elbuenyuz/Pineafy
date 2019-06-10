
//  ViewController.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 9/24/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit
import Foundation
import MessageUI
import FirebaseDatabase
import Firebase

typealias DownloadComplete = () -> ()

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate, MFMailComposeViewControllerDelegate{

    let blackView = UIView()
    let IdCell = "cellId"
    let ID_ARRAY = "id"
    var resp:Bool = false
    var todayDate = ""
    var ref: DatabaseReference!
    
    lazy var settingsLaunch: SettingsLauncher = {
        let vc  = SettingsLauncher()
        vc.homeController = self
        return vc
    }()


    var spinner :UIActivityIndicatorView = {
        let spin = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spin.color = .lightGray
        spin.translatesAutoresizingMaskIntoConstraints = false
        return spin
    }()
    
    let zodiacSignImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        cv.backgroundColor = PINK_BG//bgcolor
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
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
        //        view.backgroundColor = .magenta
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel:UILabel = {
        let lbl = UILabel()
        //        lbl.backgroundColor = .yellow
        lbl.text = ""
        lbl.textAlignment = .center
        lbl.addShadowIcon()
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 35)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dateLabel:UILabel = {
        let lbl = UILabel()
        //        lbl.backgroundColor = .yellow
        lbl.text = ""
        lbl.textAlignment = .center
        lbl.textColor = UIColor(red:0.49, green:0.35, blue:0.47, alpha:1.0)
        lbl.font = UIFont(name: "JosefinSlab-Light", size: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let horoscopeInfo: UITextView = {
        let h = UITextView()
        h.font = UIFont(name: "JosefinSlab-Light", size: 20)
        //        h.backgroundColor = .orange
        h.textAlignment = .center
        h.isUserInteractionEnabled = false
        h.addShadowIcon()
        h.isHidden = false
        h.adjustsFontForContentSizeCategory = true
        h.contentInset = UIEdgeInsets(top: 20, left: 1, bottom: 0, right: 1)
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
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
        label.text = "Share with your friends"
        label.font = UIFont(name: "JosefinSlab-Bold", size: 23)
        label.textColor = UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
        label.isHidden = true
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var localArray = [HoroscopeModel]()
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = PINK_BG
        
        view.backgroundColor = PINK_BG//bgcolor
        horoscopeInfo.backgroundColor = PINK_BG//bgcolor
        print("---viewdDidAppear---")
        //information daily update
        todayDate = formattedDate
        guard let localDate = UserDefaults.standard.string(forKey: KEY_FORMATTED_DATE) else {return}
        
        if localDate != todayDate{
            UserDefaults.standard.removeObject(forKey: KEY_FORMATTED_DATE)
            UserDefaults.standard.removeObject(forKey: KEY_ARRAY)
            print("---localDate: \(localDate)---")
            print("---todayDate: \(todayDate)---")
            parseUrl {
                populate()
                collectionview.reloadData()
                
            }
        }else{
            print("---localDate not different: \(localDate)---")
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        populate()
        setupView()
        if let date = UserDefaults.standard.string(forKey: KEY_USER_DATE){
            self.navigationController?.navigationBar.isUserInteractionEnabled = true
            self.handleHidden()
            
        }else{
            self.navigationController?.navigationBar.isUserInteractionEnabled = false
        }
        print("---viewdWillAppear---")
        self.collectionview.backgroundColor = PINK_BG
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = PINK_BG
    }
    
    //Function to populate if there is any [Array] saved in userDefaults
    func populate(){
        //get result from UserDefault
        if let result = UserDefaults.standard.dictionary(forKey: KEY_ARRAY){
            //empty arrays
            localArray = []
            arrayHoroscopes = []
            //ke from the dic
            let keys = result.keys
            
            //for x in the array
            print("keys : \(keys)")
            for key in keys{
                guard let scopeDic = result[key] as? [String: Any] else {return}
                
                if let scopeInfo = scopeDic["horoscope"] as? String, let scopeName = scopeDic["sunsign"] as? String, let scopeDate = scopeDic["date"] as? String {
                    let image = self.handleImage(key: scopeName)
                    let model = HoroscopeModel(horoscope: scopeInfo, sign: scopeName, date: scopeDate, image: image)

                    arrayHoroscopes.append(model)
                    localArray.append(model)
					
                }
            }
            //Friends horoscope updates
            collectionview.reloadData()
            
        }else{
            parseUrl {                
                
            }
        }
       
    if let nameScope =  UserDefaults.standard.string(forKey: KEY_USER_SIGN){
        navigationController?.navigationBar.topItem?.title = nameScope
        for x in localArray{
                if nameScope == x.sign{
                    updateView(horoscope: x)
                    
                }
            }
        }
    }
    
    func setupViews(){
        // Do any additional setup after loading the view, typically from a nib.
       
        descriptionContainer.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        descriptionContainer.contentSize = CGSize(width: self.view.frame.width, height: 600)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showPickerView), name: Notification.Name.tabVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopupClosing), name: Notification.Name.bDate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleRegister), name: Notification.Name.register, object: nil )
        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendShareHorosocope), name: NSNotification.Name.shareFriend, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handledismissBlackView), name: NSNotification.Name.dismiss, object: nil)
        
        collectionview.register(friendHoroscopeCell.self, forCellWithReuseIdentifier: IdCell)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---viewdDidLoad---")
        //check if users date is saved locally
        if UserDefaults.standard.string(forKey: KEY_USER_DATE) == nil{
            presentWalkthrough()
        }
        
        setupViews()
        //NAvigationBar Setup
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "burgMenu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBurguerMenuAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "mklogo").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAccessPineafyAstrologers))
        
    }
    
    @objc func handleRegister(){
        self.navigationController?.pushViewController(FormVC(), animated: true)
    }
    
    @objc func handleAccessPineafyAstrologers(){
        print("premium")
        if let mail = UserDefaults.standard.string(forKey: KEY_EMAIL_USER), let name = UserDefaults.standard.string(forKey: KEY_NAME_USER){
            print("user already registered, name: \(name) email: \(mail)")
            navigationController?.pushViewController(CategoryVC(), animated: true)
        }else{
            print("user NOT regsitered yet!")
            navigationController?.pushViewController(FormVC(), animated: true)
        }
        
    }
    
    @objc func handleBurguerMenuAction(){
        print("toolBtn pressed")
        settingsLaunch.showSettings()
    }
    
    //Need to be fixed the way we handle sharing the information.
    @objc func handleFriendShareHorosocope(notification: Notification){
        let name = notification.object as! HoroscopeModel
        if let scope = name.horoscope, let scopeName = name.sign{
            shareAction(scope: scope, signName: scopeName)
        }else{
            print("error hughe")
        }
    }

    func parseUrl(completion: () -> ()){
        //save date from today
        UserDefaults.standard.set("\(formattedDate)", forKey: KEY_FORMATTED_DATE)
 
        let urlCompleta = "http://www.pineafy.com/backend/fetchScopes/\(formattedDate)"
        print("formated date to send api request-- http://www.pineafy.com/backend/fetchScopes/\(formattedDate)")
        
        guard let url = URL(string: urlCompleta) else {return}
        
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
                UserDefaults.standard.set(array, forKey: KEY_ARRAY)
                UserDefaults.standard.synchronize()
                
                print("array saliendo: \(self.arrayHoroscopes.count)")
                
                DispatchQueue.main.async {
                    self.populate()
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        completion()
    }
    
    var formattedDate: String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let day = Date()
        return format.string(from: day)
    }
    
    //Dismiss the black View oresented to show something
    @objc func handledismissBlackView(){
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            let heigth: CGFloat = 400
            if let window = UIApplication.shared.keyWindow{
                self.datePickerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
                self.friendHorosocope.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
                
            }
            
        }) { (completed: Bool) in
            
        }
    }
    
    //Present The walkthrough once cicles
    func presentWalkthrough(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let myCollectionVC = SwipingController(collectionViewLayout: layout)
        blackView.isUserInteractionEnabled = true
        navigationController?.present(myCollectionVC, animated: true, completion: nil)
        
    }
    
    
    //Send the email information
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
    var numb = 0
    
    //share the information with the phone tools
    @objc func shareAction(scope: String, signName: String){
        print("share")
        let myWebsite = NSURL(string:"https://goo.gl/Kfb7s9")
        let text = "\(signName.uppercased()), \n\n\(scope)\n\nDownload the App \n\(myWebsite!)"
        
        let shareAll: [Any] = [text]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        
        
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.navigationController?.navigationBar.topItem?.title = "Share Insight"
        
        self.present(activityViewController, animated: true) {
            
            activityViewController.completionWithItemsHandler = { (activityType, completed:Bool, returnedItems:[Any]?, error: Error?) in
                if completed {
                    
                }
                
                switch completed{
                case true:
                    self.numb = self.numb + 1
                    print("actions completed: \(self.numb)")
                    
                    Analytics.logEvent("share_sign", parameters: [
                        AnalyticsParameterItemID: "id-\(signName)",
                        AnalyticsParameterScore: self.numb
                        ])
                    
                case false:
                    print("churn")
                }
            }
        }
        
    }
    
    
    //CollectionViewControllers
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("items in collection :\(arrayHoroscopes.count)")
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
        let vc = FriendVC()
    
        vc.horoscope = model
//        self.showFriendhoroscope()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIColor{
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func loadView() {
        view = UIView()
//        color UIColor(white: 0, alpha: 0.7)
        
        view.backgroundColor = .clear
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        spinner.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: 300).isActive = true

        
    }
    
    
}
