//
//  Models.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 7/26/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    var name:String?
    var apps: [App]?
    
    static func sampleAppCategories() -> [AppCategory] {
        var dailyHoroscope = AppCategory()
        dailyHoroscope.name = "Daily Horoscope"
        
        //Daily
        var apps = [App]()
        
        //logic onjects
        let dayHoroscope = App()
        dayHoroscope.name = "Pisces"
        dayHoroscope.detail = "1 august 2018"
        dayHoroscope.price = "Free"
        dayHoroscope.imageName = #imageLiteral(resourceName: "pisces")
        apps.append(dayHoroscope)
        dailyHoroscope.apps = apps
        
        //Weekly
        let weeklyHoroscope = AppCategory()
        weeklyHoroscope.name = "Weekly Horoscope"
        
        var wCategoryApps = [App]()
        
        //logic onjects
        let weekHoroscope = App()
        weekHoroscope.name = "Capricorn"
        weekHoroscope.detail = "2/Aug - 9/Aug"
        weekHoroscope.price = "$0.99"
        weekHoroscope.imageName = #imageLiteral(resourceName: "pisces")
        wCategoryApps.append(weekHoroscope)
        weeklyHoroscope.apps = wCategoryApps
        
       //
        return [dailyHoroscope, weeklyHoroscope]
    }
}

class App: NSObject {
    var id: NSNumber?
    var detail:String?
    var imageName:UIImage?
    var name:String?
    var price: String?
    
}
