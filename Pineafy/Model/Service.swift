//
//  Service.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 3/14/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

struct Service {
    
    let name: String
    let duration: String
    let typeService: String
    let description: String
    let cost: Int
    
    init(name:String, duration: String, type:String, about:String,cost:Int) {
        self.name = name
        self.duration = duration
        self.typeService = type
        self.description = about
        self.cost = cost
    }
}
