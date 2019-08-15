
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
//    var ref: DatabaseReference!
	
	
	var arrayHoroscopes = [HoroscopeModel]()
	/**
	List of the screen items Start
	*/
	
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
        let text = UITextView()
        text.font = UIFont(name: "JosefinSlab-Light", size: 18)
        text.textAlignment = .center
        text.isUserInteractionEnabled = true
		text.isScrollEnabled = true
		text.textAlignment = .justified
		text.sizeToFit()
        text.addShadowIcon()
        text.isHidden = false
        text.adjustsFontForContentSizeCategory = true
        text.contentInset = UIEdgeInsets(top: 20, left: 1, bottom: 0, right: 1)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
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
        label.font = UIFont(name: "JosefinSlab-Bold", size: 18)
        label.textColor = UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
        label.isHidden = true
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
	
	let callToActionView: ButtonAndImageView = {
		let view = ButtonAndImageView()
		view.isUserInteractionEnabled = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let navigationBar: UINavigationBar = {
		let bar = UINavigationBar()
		return bar
	}()
	/**
	List of the screen items Ends
	*/
	@objc func handleCTA(){
		print("handle CTA")
		self.navigationController?.pushViewController(CategoryVC() ,animated: true)
	}
	
	//ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
		print("---viewdDidAppear---")
		let gesture = UITapGestureRecognizer(target: self, action: #selector(handleCTA))
		callToActionView.addGestureRecognizer(gesture)
		
		//Editing the NavigationBar
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = PINK_BG
		//Editing the background color of the viewcontroller
		view.backgroundColor = PINK_BG//bgcolor
		//Editing the background color of the horoscopeInfo View
        horoscopeInfo.backgroundColor = PINK_BG//bgcolor
		
		//today variable with a type of value date, that would help us to make the
		//call to the webservice providing the horoscope of the date selected
        todayDate = formattedDate
		
		//verificamos si hay informacion sobre la fecha actual dentro de UserDefaults
        guard let localDate = UserDefaults.standard.string(forKey: KEY_FORMATTED_DATE) else {return}
		//if the date is diferent from the one saved we replace the date with today's date
        if localDate != todayDate{
			//we remove the reference saved inside UserDefaults for the actual date
            UserDefaults.standard.removeObject(forKey: KEY_FORMATTED_DATE)
			//we remove the information of the array saved in UserDefaults so we can bring the new one form today
			UserDefaults.standard.removeObject(forKey: KEY_ARRAY)
			//print today date and  saved locally date
			print("---localDate: \(localDate)---")
            print("---todayDate: \(todayDate)---")
			
			//Download and parse the Json
            parseUrl {
				//Fetch the horoscopes
                populate()
				//reload collectionView for horoscopes
                collectionview.reloadData()
            }
        }else{
			//the date is correct from today
            print("---localDate not different: \(localDate)---")
        }
    }
    
    
    //ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
		//Fetch array of horoscopes
		populate()
		//SetupView
        setupView()
		
		
		//this piece of code help us when we ask for the bday, to keep the background menu unabled for the user
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
	
	//Function to setup the views for the CollectionView and the Notofication Center
    func setupViews(){
		//Insets for the descriptionContainer
		
		
//Notification Center // Need to double check this ones    <---- <---- <---- <---- <---- <---- <----
        NotificationCenter.default.addObserver(self, selector: #selector(showPickerView), name: Notification.Name.tabVC, object: nil)
		//Send notification from The bDay when confirm close the view
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopupClosing), name: Notification.Name.bDate, object: nil)
		//send the notification from the user account to show the register ViewController
		NotificationCenter.default.addObserver(self, selector: #selector(handleRegister), name: Notification.Name.register, object: nil )
		
		NotificationCenter.default.addObserver(self, selector: #selector(handleFriendShareHorosocope), name: NSNotification.Name.shareFriend, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handledismissBlackView), name: NSNotification.Name.dismiss, object: nil)
		
		//collectionView Setup
        collectionview.register(friendHoroscopeCell.self, forCellWithReuseIdentifier: IdCell)
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.showsHorizontalScrollIndicator = false
    }
	
	//ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---viewdDidLoad---")
        //check if users date is saved locally if not present the Walkthrough
        if UserDefaults.standard.string(forKey: KEY_USER_DATE) == nil{
            presentWalkthrough()
        }
        //Call setupViews
        setupViews()
        //NavigationBar Setup add Button Menu
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "burgMenu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleBurguerMenuAction))
        
    }
	
	//fucntion attached to the notification center to show the FromVC
    @objc func handleRegister(){
        self.navigationController?.pushViewController(FormVC(), animated: true)
    }
	
	//Right Navigation Button created to get access to the marketplace.
    @objc func handleAccessPineafyAstrologers(){
        print("premium")

		navigationController?.pushViewController(CategoryVC(), animated: true)
		//navigationController?.pushViewController(FormVC(), animated: true)

        
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
	
//	Download and parse de json to [ARRAY]
    func parseUrl(completion: () -> ()){
		//save date from today
		UserDefaults.standard.set("\(formattedDate)", forKey: KEY_FORMATTED_DATE)
		
		let urlCompleta = "http://www.pineafy.com/backend/fetchScopes/"
		
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
				
				guard let array = jsonResponse as? [String: Any] else {return}
				let keyArray = Array(array.keys)
				
				for object in array{
					let value = object.value as? [String: Any]
					print("el valor : \(object)")
				}
				
				
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
	
	//Function to populate if there is any [Array] saved in userDefaults
	//Received an [Array]
	func populate(){
		//get the array saved in userdefaults
		if let result = UserDefaults.standard.dictionary(forKey: KEY_ARRAY){
			//empty arrays to save information
			arrayHoroscopes = []
			
			//let keys: Dictionary<String, Any>. Keys
			let keys = result.keys

			//with the key we iterate the Dictionary of horoscopes
			print("keys : \(keys)")
			for key in keys{
				//Guard the item that we get from the Dictionary
				guard let scopeDic = result[key] as? [String: Any] else {return}
				//We create the values from the Horoscope Model
				if let scopeInfo = scopeDic["horoscope"] as? String, let scopeName = scopeDic["sunsign"] as? String, let scopeDate = scopeDic["date"] as? String {
					let image = self.handleImage(key: scopeName)
					//We create model Horoscope
					let model = HoroscopeModel(horoscope: scopeInfo, sign: scopeName, date: scopeDate, image: image)
					//We append the model to the array
					arrayHoroscopes.append(model)
					
				}
			}
			//At the end we Reload the data from the friends Horoscopes CollectionView.
			collectionview.reloadData()
			
		}else{
			//Si no existe el Dic mandamos el request a la API
			parseUrl {
				
			}
		}
		//We select the bday and the sign related and we update the view with his sign related
		if let nameScope =  UserDefaults.standard.string(forKey: KEY_USER_SIGN){
			navigationController?.navigationBar.topItem?.title = nameScope
			for x in arrayHoroscopes{
				if nameScope == x.sign{
					//update view with the personal user sign horoscope
					updateView(horoscope: x)
					
				}
			}
		}
	}
	
	func saveLocallyHoroscopesArray(array: [Any]) -> Bool{
		return true
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
        return CGSize(width: 90, height: 70)
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
