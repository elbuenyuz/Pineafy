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
class FeedbackLauncher: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
	
	let feedbacks = [FeedbackModel(title: "-Is Amazing-", feedback: "First time booking a reading and it was amazing, bright insight and it help me to move on.", createdBy: "Stephanie Wilson"),FeedbackModel(title: "-Unbelievable-", feedback: "First time booking a reading and it was amazing, bright insight and it help me to move on.", createdBy: "Stephanie Wilson"),FeedbackModel(title: "-Is Great-", feedback: "First time booking a reading and it was amazing, bright insight and it help me to move on.", createdBy: "Stephanie Wilson"),FeedbackModel(title: "-Worth it!-", feedback: "First time booking a reading and it was amazing, bright insight and it help me to move on.", createdBy: "Stephanie Wilson")]
	var homeController: CategoryDetailVC?
	
	let collectionV: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.layer.cornerRadius = 5
		cv.backgroundColor = .white
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()
	
	let titleLabel: UILabel = {
		let name = UILabel()
		name.font = UIFont(name: "JosefinSlab-Bold", size: 30)
		name.text = "FEEDBACKS"
		name.textColor = BLUE_TITLE
		name.textAlignment = .center
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	var feedbackArray:[FeedbackModel] = []
//	arraySettingsMenu
	
	func setupView(){
		print("entro")
		self.addSubview(titleLabel)
		titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
		titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		self.addSubview(collectionV)
		collectionV.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5).isActive = true
		collectionV.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -5).isActive = true
		collectionV.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
		collectionV.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		collectionV.register(FeedbackCell.self, forCellWithReuseIdentifier: "idFeedback")
		collectionV.delegate = self
		collectionV.dataSource = self
		collectionV.showsVerticalScrollIndicator = false
		collectionV.contentInset = UIEdgeInsets(top: 0, left: -10, bottom: 10, right: -10)
		feedbackArray = feedbacks
		setupView()
		print("called")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		print("feedbackcount: \(feedbackArray.count)")
		return feedbackArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionV.dequeueReusableCell(withReuseIdentifier: "idFeedback", for: indexPath) as! FeedbackCell
		let feedback = feedbackArray[indexPath.item]
		cell.feedback = feedback
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionV.frame.width, height: 150)
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		
		return 10
	}
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
}










