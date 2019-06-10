//
//  titleDescView.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 5/20/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import UIKit

class titleDescView: UIView{
	
	let title: UILabel = {
		let label = UILabel()
		label.text = "About"
		label.font = UIFont(name: "JosefinSlab-Bold", size: 28)
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let desc: UILabel = {
		let label = UILabel()
		label.text = "A style icon gets some love from one of today's top trendsetters. Pharrell Williams puts his creative spin on these shoes, which have all the clean, classic details of the beloved Stan Smith."
		label.numberOfLines = 7
		label.font = UIFont(name: "JosefinSlab-Regular", size: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupView(){
		self.addSubview(title)
		title.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
		title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		title.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
		title.heightAnchor.constraint(equalToConstant: 30).isActive = true
		
		self.addSubview(desc)
		desc.topAnchor.constraint(equalTo: self.title.bottomAnchor).isActive = true
		desc.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		desc.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
		desc.heightAnchor.constraint(equalToConstant: 80).isActive = true
	}
}
