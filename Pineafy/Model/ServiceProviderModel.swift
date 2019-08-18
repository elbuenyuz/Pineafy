//
//  CategotyModel.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 5/2/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import Foundation
import UIKit

struct ServiceProviderModel{
	let name: String?
	let rate: UIImage?
	let profileImg: UIImage?
	let price: String?
	let batch: String?
	let feedbacks: String?
	let spots: String?
	
	
	init(name: String, rate: UIImage, profileImg: UIImage, price: String, batch: String, feedbacks: String, spots: String) {
		
		self.name = name
		self.rate = rate
		self.profileImg = profileImg
		self.price = price
		self.batch = batch
		self.feedbacks = feedbacks
		self.spots = spots
	}
	
	
}
