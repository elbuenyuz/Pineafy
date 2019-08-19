//
//  SettingsCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//
import Foundation
import UIKit

class ProviderCellPerfect: BaseCell {
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
			star.image = unwrappedService.rate
		}
	}
	
	let nameProvider: UILabel = {
		let name = UILabel()
		name.text = "Isabella Rodriguez"
		name.font = UIFont(name: "JosefinSlab-Bold", size: 22)
		name.textAlignment = .left
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	let star: UIImageView = {
		let image = UIImageView()
		image.image = #imageLiteral(resourceName: "star")
		image.contentMode = UIViewContentMode.scaleAspectFit
		image.translatesAutoresizingMaskIntoConstraints = false
		return image
	}()
	
	let priceLabel: UILabel = {
		let price = UILabel()
		price.text = "$59.99"
		price.font = UIFont(name: "JosefinSlab-Bold", size: 18)
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
	
	let feedbackLabel: UITextView = {
		let lbl = UITextView()
		lbl.text = "5 feedbacks"
		lbl.textContainerInset = UIEdgeInsets(top: 3, left: 5, bottom: 0, right: 0)
		lbl.isUserInteractionEnabled = false
		lbl.textColor = UIColor(red:0.41, green:0.67, blue:0.93, alpha:1.0)
		lbl.backgroundColor = UIColor(red:0.97, green:0.83, blue:0.83, alpha:1.0)
		lbl.font = UIFont(name: "JosefinSlab-Bold", size: 18)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	let spotLeftLabel: UITextView = {
		let lbl = UITextView()
		lbl.textContainerInset = UIEdgeInsets(top: 3, left: 5, bottom: 0, right: 0)
		lbl.text = "2 spots left this week"
		lbl.backgroundColor = UIColor(red:1.00, green:0.95, blue:0.95, alpha:1.0)
		lbl.isUserInteractionEnabled = false
		lbl.textColor = UIColor(red:0.10, green:0.85, blue:0.64, alpha:1.0)
		lbl.font = UIFont(name: "JosefinSlab-Bold", size: 18)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	let container: UIView = {
		let container = UIView()
		//		container.backgroundColor = .purple
		container.translatesAutoresizingMaskIntoConstraints = false
		return container
	}()
	
	let rateLabel: UILabel = {
		let lbl = UILabel()
		lbl.text = "5.0"
		lbl.textColor = .gray
		lbl.font = UIFont(name: "JosefinSlab-Bold", size: 18)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
	}()
	
	let batchLabel: UILabel = {
		let batch = UILabel()
		batch.text = "Exclusive Astrologers"
		batch.textColor = UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
		batch.font = UIFont(name: "JosefinSlab-regular", size: 18)
		batch.translatesAutoresizingMaskIntoConstraints = false
		return batch
	}()

	override func setupViews() {
		
		self.addSubview(profileImg)
		profileImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
		profileImg.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 15).isActive = true
		profileImg.widthAnchor.constraint(equalToConstant: 80).isActive = true
		profileImg.heightAnchor.constraint(equalToConstant: 80).isActive = true
		
		self.addSubview(container)
		container.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
		container.leftAnchor.constraint(equalTo: profileImg.rightAnchor, constant: 5).isActive = true
		container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
		container.heightAnchor.constraint(equalToConstant: 100).isActive = true
		
		self.addSubview(priceLabel)
		priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		priceLabel.centerXAnchor.constraint(equalTo: profileImg.centerXAnchor).isActive = true
		priceLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
		priceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
		
		self.addSubview(rateLabel)
		rateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
		rateLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor).isActive = true
		rateLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
		rateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		self.addSubview(star)
		star.rightAnchor.constraint(equalTo: rateLabel.leftAnchor).isActive = true
		star.centerYAnchor.constraint(equalTo: rateLabel.centerYAnchor,constant: -2).isActive = true
		star.widthAnchor.constraint(equalToConstant: 20).isActive = true
		star.heightAnchor.constraint(equalToConstant: 20).isActive = true
		
		
//		container view setup
		container.addSubview(nameProvider)
		nameProvider.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
		nameProvider.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		nameProvider.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
		nameProvider.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		container.addSubview(batchLabel)
		batchLabel.topAnchor.constraint(equalTo: nameProvider.bottomAnchor).isActive = true
		batchLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		batchLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
		batchLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		container.addSubview(feedbackLabel)
		feedbackLabel.topAnchor.constraint(equalTo: batchLabel.bottomAnchor).isActive = true
		feedbackLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		feedbackLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
		feedbackLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
		container.addSubview(spotLeftLabel)
		spotLeftLabel.topAnchor.constraint(equalTo: feedbackLabel.bottomAnchor).isActive = true
		spotLeftLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
		spotLeftLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
		spotLeftLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
		
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



