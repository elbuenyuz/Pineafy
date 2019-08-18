//
//  CategoryDetailVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 5/4/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class CategoryDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	var blackView = UIView()
	var titleCatgegory = ""
	var ref: DatabaseReference!
	
	var services: [ServiceProviderModel] = []
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		//		layout.scrollDirection = .horizontal
		layout.minimumInteritemSpacing = 20
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .clear
		cv.showsVerticalScrollIndicator = false
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()
    
    var SignInVC: signInVC?
    
	
	let feedbackView: FeedbackLauncher = {
		let view = FeedbackLauncher()
		view.layer.cornerRadius = 10
		view.clipsToBounds = true
		view.backgroundColor = .clear
		return view
	}()
    
    let signInView: signInVC = {
        let view = signInVC()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
	
    }()
	let profileView: ProfileView = {
		let view = ProfileView()
		view.layer.cornerRadius = 10
		view.clipsToBounds = true
		view.backgroundColor = .white
		
		
		return view
	}()
	
	let astrologersLabel: UILabel = {
		let label = UILabel()
		label.text = "Choose an astrologer"
		label.font = UIFont(name: "JosefinSlab-Bold", size: 23)
		label.textColor = UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
		label.backgroundColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let descCategory: UILabel = {
		let desc = UILabel()
		desc.font = UIFont(name: "JosefinSlab-Regular", size: 20)
		desc.text = "It is never late to find out why your finances are not as expect to be, Find insight with one of our services created by Professional Astrologers."
		desc.numberOfLines = 10
		desc.textAlignment = .justified
		desc.translatesAutoresizingMaskIntoConstraints = false
		return desc
	}()
	func getProviders(){
		ref = Database.database().reference().child("providers")
		self.ref.observe(.value, with: { (snapshot) in
		let snap = snapshot.value as? NSDictionary
			
			//UID Filter firebase database per provider
			let general = snap?["a12312312jqouhe9u"] as? [String:Any]
			let account  = general?["account"] as? [String:Any]
			print("snapshot:\( account)")
			let name = account?["name"] as? String ?? ""
			let price = "130"
			let desc = account?["desc"] as? String ?? ""
			let imgName = account?["url"] as? String ?? ""
			let rate = account?["rate"] as? String ?? ""
			guard let img = UIImage(named: imgName),let imgRate = UIImage(named: rate) else {return}
			print("snap \(name), price\(price)")
		}) { (error) in
			print("error")
		}
			
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.services.append(ServiceProviderModel(name: "Isabella Rodriguez", rate: #imageLiteral(resourceName: "star") , profileImg: #imageLiteral(resourceName: "profileImg3"), price: "$120.00", batch: "Exclusive Astrologer", feedbacks: "5", spots: "10"))
		self.services.append(ServiceProviderModel(name: "Isabella Rodriguez", rate: #imageLiteral(resourceName: "star") , profileImg: #imageLiteral(resourceName: "profileImg"), price: "$120.00", batch: "Exclusive Astrologer", feedbacks: "5", spots: "10"))
		self.services.append(ServiceProviderModel(name: "Isabella Rodriguez", rate: #imageLiteral(resourceName: "star") , profileImg: #imageLiteral(resourceName: "profileImg2"), price: "$120.00", batch: "Exclusive Astrologer", feedbacks: "5", spots: "10"))
		self.services.append(ServiceProviderModel(name: "Isabella Rodriguez", rate: #imageLiteral(resourceName: "star") , profileImg: #imageLiteral(resourceName: "profileImg"), price: "$120.00", batch: "Exclusive Astrologer", feedbacks: "5", spots: "10"))
		blackView.backgroundColor = .red
		blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handledismissBlackView)))
		blackView.isUserInteractionEnabled = true
		view.backgroundColor = PINK_BG
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(ProviderCellPerfect.self, forCellWithReuseIdentifier: "providerId")
		setupView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		getProviders()
	}
	
	func setupView(){
		view.addSubview(collectionView)
		collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 170).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		
		view.addSubview(astrologersLabel)
		astrologersLabel.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: -5).isActive = true
		astrologersLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
		astrologersLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		astrologersLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		view.addSubview(descCategory)
		descCategory.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		descCategory.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
		descCategory.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
		descCategory.bottomAnchor.constraint(equalTo: self.astrologersLabel.topAnchor).isActive = true
	}
	
	override func viewDidAppear(_ animated: Bool) {
//		self.blackView.backgroundColor = UIColor(white: 0, alpha: 0.9)
		self.navigationController?.navigationBar.topItem?.title = titleCatgegory
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return services.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "providerId", for: indexPath) as! ProviderCellPerfect
		let serv = services[indexPath.item]
		cell.delegate = self
		cell.service = serv
		cell.layer.cornerRadius = 10
		cell.layer.masksToBounds = true
		cell.backgroundColor = .white
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
	
	return CGSize(width: collectionView.frame.width - 10, height: 150)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		
		return 20
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		self.navigationController?.pushViewController(BookingVC(), animated: true)
	}
}

extension CategoryDetailVC: ProviderCellButtonTappedDelegate {
	func didProfileTapped() {
		showProfileProvider()
	}
	
	func didFeedbackTapped() {
		print("feedbacktapped")
		showFeedbacks()
		
		
	}
	
	func didBookingTapped() {
		print("boooking tapped")
        //SignInVC?.showSettings()
//        showSignIn()
		
		navigationController?.present(FormVC(), animated: true, completion: {		
		})
        //navigationController?.pushViewController(signInVC(), animated: true)
	}
}


//feedback show
extension CategoryDetailVC {
    
    func showSignIn(){
        
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            
            window.addSubview(blackView)
            window.addSubview(signInView)
            
            //collectionV
            let heigth: CGFloat = 550
            
            //modificar posicion inicial de la colleccion
            signInView.frame = CGRect(x: 0, y: (0 - window.frame.height) - 30, width: window.frame.width - 20, height: heigth)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            //animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.signInView.frame = CGRect(x: window.frame.width/2 - self.signInView.frame.width/2, y: 30, width: self.signInView.frame.width, height: self.signInView.frame.height)
                
            }, completion: nil)
        }
    }
	
	func showFeedbacks(){
		
		if let window = UIApplication.shared.keyWindow{
			
			blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
			
			window.addSubview(blackView)
			window.addSubview(feedbackView)
			
			//collectionV
			let heigth: CGFloat = 550
			
			//modificar posicion inicial de la colleccion
			feedbackView.frame = CGRect(x: 0, y: (0 - window.frame.height) - 30, width: window.frame.width - 20, height: heigth)
			
			blackView.frame = window.frame
			blackView.alpha = 0
			
			//animation
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
				
				self.blackView.alpha = 1
				
				self.feedbackView.frame = CGRect(x: window.frame.width/2 - self.feedbackView.frame.width/2, y: 30, width: self.feedbackView.frame.width, height: self.feedbackView.frame.height)
				
			}, completion: nil)
		}
	}
	
	
	func presentBlackScreen(){
		if let window = UIApplication.shared.keyWindow{
			window.addSubview(blackView)
			
			blackView.frame = window.frame
			blackView.alpha = 0
		}
	}
	
	@objc func handledismissBlackView(){
		print("tap tap")
		UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
			self.blackView.alpha = 0
			let heigth: CGFloat = 400
			if let window = UIApplication.shared.keyWindow{
				self.feedbackView.frame = CGRect(x: 0, y: (0 - window.frame.height) - 40, width: window.frame.width - 20, height: heigth)
                self.signInView.frame = CGRect(x: 0, y: (0 - window.frame.height) - 40, width: window.frame.width - 20, height: heigth)
				self.profileView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
			}
			
		}) { (completed: Bool) in
			
		}
	}
	
	func showProfileProvider(){
		if let window = UIApplication.shared.keyWindow{
			
			blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
			
			window.addSubview(blackView)
			window.addSubview(profileView)
			
			//collectionV
			let heigth: CGFloat = 550
			
			//modificar posicion inicial de la colleccion
			
			profileView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
			
			blackView.frame = window.frame
			blackView.alpha = 0
			
			//animation
			UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
				
				self.blackView.alpha = 1
				
					self.profileView.frame = CGRect(x: window.frame.width/2 - window.frame.width/2, y: window.frame.height - heigth, width: window.frame.width, height: self.profileView.frame.height - 50)
				
			}, completion: nil)
		}
	}
}
