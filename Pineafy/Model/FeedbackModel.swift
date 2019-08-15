//
//  FeedbackModel.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 5/12/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import Foundation
import UIKit

struct FeedbackModel{
	let title: String?
	let feedback: String?
	let createdBy: String?

	
	init(title: String, feedback: String, createdBy: String){
		
		self.title = title
		self.feedback = feedback
		self.createdBy = createdBy

	}
	
}
