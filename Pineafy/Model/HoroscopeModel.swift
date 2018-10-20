//
//  HoroscopeModel.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 10/3/18.
//  Copyright © 2018 Devius. All rights reserved.
//
import UIKit
import Foundation
struct HoroscopeModel: Decodable{
    let horoscope: String?
    let sign: String?
    let date: String?
   
//    enum CodingKeys: String, CodingKey {
//        case horoscope
//        case sunsign
//        case date
//    }

    init(json: [String: Any]) {

        self.horoscope = json["horoscope"] as? String
        self.sign = json["sunsign"] as? String
        self.date = json["date"] as? String

    }

}


