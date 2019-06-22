//
//  SettingsCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class FirstStepCell: BaseCell {
	//Creamos un objeto
	var homeController: FourStepsVC?
	
	var feedback: FeedbackModel? {
		didSet{
//			guard let unwrappedFeedback = feedback else {return}
//			self.titleLabel.text = unwrappedFeedback.title
//			self.descFeedback.text = unwrappedFeedback.feedback
//			self.name.text = unwrappedFeedback.createdBy
			
		}
	}
	
	let titleLabel: UILabel = {
		let name = UILabel()
		name.font = UIFont(name: "JosefinSlab-Bold", size: 29)
		name.text = "What is your full name?"
		name.textColor = .black
		name.textAlignment = .left
		name.addShadowText()
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	let name: UITextField = {
		let name = UITextField()
		name.font = UIFont(name: "JosefinSlab-Regular", size: 25)
		name.placeholder = "Name"
		name.textColor = .black
		name.returnKeyType = .next
		name.textAlignment = .left
		name.layer.cornerRadius = 10
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	
	override func setupViews() {
		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
		self.backgroundColor = .white
		
		addSubview(titleLabel)
		titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
		titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
		titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

		addSubview(name)
		name.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10).isActive = true
		name.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor,constant: 5).isActive = true
		name.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor).isActive = true
		name.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		
		
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViews()
		addDoneButtonOnKeyboard()
	}
	
	
	func addDoneButtonOnKeyboard(){
		let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
		doneToolbar.barStyle = .default
		
		let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let done: UIBarButtonItem = UIBarButtonItem(title: "Next :)", style: .done, target: self, action: #selector(self.doneButtonAction))
		
		let items = [flexSpace, done]
		doneToolbar.items = items
		doneToolbar.sizeToFit()
		name.inputAccessoryView = doneToolbar

	}
	
	@objc func doneButtonAction(){
		print("Pressed, save informastion")
		self.homeController?.MoveToNextCell()
		
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}



