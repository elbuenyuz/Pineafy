//
//  CategotyModel.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 5/2/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import Foundation
import UIKit

struct CategoryModel: Decodable{
	let name: String?
	let image: String?
	let description: String?
	
	
	//    enum CodingKeys: String, CodingKey {
	//        case horoscope
	//        case sunsign
	//        case date
	//    }
	
	init(name: String,image: String, description: String) {
		
		self.name = name
		self.image = image
		self.description = description
	}
	
	
}
