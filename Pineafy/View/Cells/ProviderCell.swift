//
//  SettingsCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//
import Foundation
import UIKit

protocol ProviderCellButtonTappedDelegate {
	func didFeedbackTapped()
	func didBookingTapped()
	func didProfileTapped()
}

class ProviderCell: BaseCell {
	var delegate: ProviderCellButtonTappedDelegate?
	//hightlight
	override var isHighlighted: Bool{
		
		didSet{
//			backgroundColor = isHighlighted ? UIColor.darkGray: .white
//			CategoryName.textColor = isHighlighted ? UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0) : .white
//
		}
	}
	
	//Creamos un objeto
	var service: ServiceProviderModel? {
		didSet{
			guard let unwrappedService = service else {return}
			nameProvider.text = unwrappedService.name
			priceLabel.text = unwrappedService.price
			profileImg.image = unwrappedService.profileImg
			rateImage.image = unwrappedService.rate
		}
	}
	
	let nameProvider: UILabel = {
		let name = UILabel()
		name.text = "Isabella Rodriguez"
		name.font = UIFont(name: "JosefinSlab-Bold", size: 26)
		name.textAlignment = .center
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	let rateImage: UIImageView = {
		let image = UIImageView()
		image.image = #imageLiteral(resourceName: "rate45")
		image.contentMode = UIViewContentMode.scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let priceLabel: UILabel = {
		let price = UILabel()
		price.text = "$59.99"
		price.font = UIFont(name: "JosefinSlab-Bold", size: 20)
		price.textColor = .gray
		price.textAlignment = .right
		price.translatesAutoresizingMaskIntoConstraints = false
		return price
	}()
	
	let profileImg: UIImageView = {
		let img = UIImageView()
		img.image = #imageLiteral(resourceName: "profileImg")
		img.isUserInteractionEnabled = true
		img.translatesAutoresizingMaskIntoConstraints = false
		return img
	}()
	
	let containerBottom: UIView = {
		let container = UIView()
//		container.backgroundColor = .purple
		container.translatesAutoresizingMaskIntoConstraints = false
		return container
	}()
	
	let feedbackLabel: UILabel = {
		let profile = UILabel()
		profile.text = "FEEDBACK"
		profile.textAlignment = .center
		profile.textColor = .white
		profile.isUserInteractionEnabled = true
		profile.backgroundColor = UIColor(red:0.41, green:0.67, blue:0.93, alpha:1.0)
		profile.translatesAutoresizingMaskIntoConstraints = false
		return profile
	}()
	
	let bookLabel: UILabel = {
		let profile = UILabel()
		profile.text = "BOOK"
		profile.textAlignment = .center
		profile.textColor = .white
		profile.isUserInteractionEnabled = true
		profile.backgroundColor = UIColor(red:0.10, green:0.85, blue:0.64, alpha:1.0)
		profile.translatesAutoresizingMaskIntoConstraints = false
		return profile
	}()
		
	override func setupViews() {
		let tapBooking = UITapGestureRecognizer(target: self, action: #selector(handleBookingTapped))
		bookLabel.addGestureRecognizer(tapBooking)
		
		let tapFeedback = UITapGestureRecognizer(target: self, action: #selector(handleFeedbackTapped))
		feedbackLabel.addGestureRecognizer(tapFeedback)
		
		let tapProfile = UITapGestureRecognizer(target: self, action: #selector(handleProfileTapped))
		profileImg.addGestureRecognizer(tapProfile)
		
		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
		self.backgroundColor = .white
		
		self.addSubview(feedbackLabel)
		feedbackLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		feedbackLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		feedbackLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
		feedbackLabel.widthAnchor.constraint(equalToConstant: self.frame.width/2).isActive = true
		
		self.addSubview(bookLabel)
		bookLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		bookLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		bookLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
		bookLabel.widthAnchor.constraint(equalToConstant: self.frame.width/2).isActive = true
		
		self.addSubview(rateImage)
		rateImage.bottomAnchor.constraint(equalTo: self.feedbackLabel.topAnchor, constant: -5).isActive = true
		rateImage.leadingAnchor.constraint(equalTo: self.feedbackLabel.leadingAnchor, constant: 5).isActive = true
		rateImage.trailingAnchor.constraint(equalTo: self.feedbackLabel.trailingAnchor).isActive = true
		rateImage.heightAnchor.constraint(equalToConstant: 35).isActive = true
		
		self.addSubview(nameProvider)
		nameProvider.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		nameProvider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
		nameProvider.heightAnchor.constraint(equalToConstant: 50).isActive = true
		nameProvider.bottomAnchor.constraint(equalTo: self.rateImage.topAnchor, constant: 5).isActive = true
		
		self.addSubview(profileImg)
		profileImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
		profileImg.trailingAnchor.constraint(equalTo: self.bookLabel.trailingAnchor, constant: -10).isActive = true
		profileImg.widthAnchor.constraint(equalToConstant: 30).isActive = true
		profileImg.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		self.addSubview(priceLabel)
		priceLabel.topAnchor.constraint(equalTo: self.profileImg.bottomAnchor).isActive = true
		priceLabel.leftAnchor.constraint(equalTo: self.rateImage.rightAnchor).isActive = true
		priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
		priceLabel.bottomAnchor.constraint(equalTo: self.bookLabel.bottomAnchor, constant: -20).isActive = true
	
	}
	@objc func handleFeedbackTapped(){
		delegate?.didFeedbackTapped()
	}
	
	@objc func handleBookingTapped(){
		delegate?.didBookingTapped()
		print("handleBooking")
	}
	
	@objc func handleProfileTapped(){
		delegate?.didProfileTapped()
	}
}


