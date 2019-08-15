//
//  ButtonAndImageView.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 8/14/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import Foundation
import UIKit

class ButtonAndImageView: UIView{
	
	let title: UILabel = {
		let label = UILabel()
		label.text = "Going through some tough situation?, Find Clarity"
		label.font = UIFont(name: "JosefinSlab-Bold", size: 18)
		label.sizeToFit()
		label.textColor = .gray
		label.numberOfLines = 2
		label.textAlignment = .center
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let img: UIImageView = {
		let img = UIImageView()
		img.image = #imageLiteral(resourceName: "mklogo")
		img.translatesAutoresizingMaskIntoConstraints = false
		return img
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()

	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//the view needs to have a height of 80
	func setupView(){
		self.addSubview(title)
		title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		title.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		title.heightAnchor.constraint(equalToConstant: 50).isActive = true
		
		self.addSubview(img)
		img.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
		img.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		img.heightAnchor.constraint(equalToConstant: 40).isActive = true
		img.widthAnchor.constraint(equalToConstant: 40).isActive = true
		
	}
}
