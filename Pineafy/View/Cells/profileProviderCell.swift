//
//  SettingsCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class ProfileProviderCell: BaseCell {
	//Creamos un objeto
	var feedback: FeedbackModel? {
		didSet{
			guard let unwrappedFeedback = feedback else {return}
			self.titleLabel.text = unwrappedFeedback.title
			self.descFeedback.text = unwrappedFeedback.feedback
			self.name.text = unwrappedFeedback.createdBy
			
		}
	}
	
	let titleLabel: UILabel = {
		let name = UILabel()
		name.font = UIFont(name: "JosefinSlab-Bold", size: 25)
		name.text = "namePrueba"
		name.textColor = .white
		name.addShadowText()
		name.textAlignment = .center
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	let descFeedback: UILabel = {
		let name = UILabel()
		name.font = UIFont(name: "JosefinSlab-Regular", size: 18)
		name.text = "namePrueba"
		name.numberOfLines = 5
		name.textColor = .black
		name.textAlignment = .center
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	let name: UILabel = {
		let name = UILabel()
		name.font = UIFont(name: "JosefinSlab-Thinitalic", size: 20)
		name.text = "namePrueba"
		name.textColor = .white
		name.textAlignment = .center
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	
	override func setupViews() {
		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
		self.backgroundColor = BLUE_TITLE
		
		
		
	}
}


