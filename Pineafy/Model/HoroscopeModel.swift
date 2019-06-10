//
//  HoroscopeModel.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 10/3/18.
//  Copyright © 2018 Devius. All rights reserved.
//
import UIKit
import Foundation

struct HoroscopeModel{
    let horoscope: String?
    let sign: String?
    let date: String?
    let image: UIImage?

//    enum CodingKeys: String, CodingKey {
//        case horoscope
//        case sunsign
//        case date
//    }
	
    init(horoscope: String,sign: String, date: String,image: UIImage) {

        self.horoscope = horoscope
        self.sign = sign
        self.date = date
        self.image = image 
    }

    
}


