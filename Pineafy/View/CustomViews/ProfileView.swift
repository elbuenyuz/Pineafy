//
//  SettingsLauncher.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

//creamos la vista y mandamos llamar el contenedor de settings
class ProfileView: UIView{
	
	lazy var contentViewSize = CGSize(width: self.frame.width, height: 630)
	
	let scrollView: UIScrollView = {
		let view = UIScrollView(frame: .zero)
		view.isScrollEnabled = true
		view.backgroundColor = .gray
		view.isUserInteractionEnabled = true
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let bgImage: UIImageView = {
		let img = UIImageView()
		img.backgroundColor = .yellow
		img.image = #imageLiteral(resourceName: "bgProviderImg")
		img.contentMode = UIViewContentMode.scaleAspectFill
		img.translatesAutoresizingMaskIntoConstraints = false
		return img
	}()
	
	let profileImg: UIImageView = {
		let img = UIImageView()
		img.backgroundColor = .clear
		img.image = #imageLiteral(resourceName: "imgProfile")
		img.contentMode = UIViewContentMode.scaleAspectFit
		img.translatesAutoresizingMaskIntoConstraints = false
		return img
	}()
	
	let feedbackView: UIImageView = {
		let view = UIImageView()
		view.image = #imageLiteral(resourceName: "certify")
		view.contentMode = UIViewContentMode.scaleAspectFit
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	
	let rateView: UIImageView = {
		let view = UIImageView()
		view.image = #imageLiteral(resourceName: "testPR")
		view.contentMode = UIViewContentMode.scaleAspectFit
		view.backgroundColor = .clear
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let aboutView: titleDescView = {
		let view = titleDescView()
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let experienceView: titleDescView = {
		let view = titleDescView()
		view.title.text = "Experience"
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let whyView: titleDescView = {
		let view = titleDescView()
		view.title.text = "Why"
		view.backgroundColor = .white
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		setupView()
		
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupView(){
		
		
		self.addSubview(bgImage)
		bgImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		bgImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
		
		bgImage.addSubview(profileImg)
		profileImg.centerXAnchor.constraint(equalTo: self.bgImage.centerXAnchor).isActive = true
		profileImg.centerYAnchor.constraint(equalTo: self.bgImage.centerYAnchor, constant: -15).isActive = true
		profileImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
		profileImg.heightAnchor.constraint(equalToConstant: 100).isActive = true
		
		guard let window = UIApplication.shared.keyWindow else {return}
		
		self.addSubview(feedbackView)
		feedbackView.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor,constant: -5).isActive = true
		feedbackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
		feedbackView.widthAnchor.constraint(equalToConstant: window.frame.width/2 - 30).isActive = true
		feedbackView.heightAnchor.constraint(equalToConstant: 50).isActive  = true
		
		self.addSubview(rateView)
		rateView.bottomAnchor.constraint(equalTo: bgImage.bottomAnchor, constant: -5).isActive = true
		rateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
		rateView.widthAnchor.constraint(equalToConstant: window.frame.width/2 - 30).isActive = true
		rateView.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		self.addSubview(scrollView)
		scrollView.contentSize = CGSize(width: self.frame.width, height: 430)
		scrollView.topAnchor.constraint(equalTo: feedbackView.bottomAnchor).isActive = true
		scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		scrollView.addSubview(aboutView)
		aboutView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
		aboutView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		aboutView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		aboutView.heightAnchor.constraint(equalToConstant: 130).isActive = true
		
		scrollView.addSubview(experienceView)
		experienceView.topAnchor.constraint(equalTo: aboutView.bottomAnchor).isActive = true
		experienceView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		experienceView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		experienceView.heightAnchor.constraint(equalToConstant: 130).isActive = true
		
		scrollView.addSubview(whyView)
		whyView.topAnchor.constraint(equalTo: experienceView.bottomAnchor).isActive = true
		whyView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		whyView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
		whyView.heightAnchor.constraint(equalToConstant: 130).isActive = true
		
	}
}










