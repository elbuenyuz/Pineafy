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
        dailyHoroscope.name = "Your Horoscope"
        
        //Daily
        var apps = [App]()
        
        //logic onjects
        let dayHoroscope = App()
        dayHoroscope.name = "Capricorn"
        dayHoroscope.detail = "Today"
        dayHoroscope.price = "Free"
        dayHoroscope.imageName = #imageLiteral(resourceName: "003-capricorn")
        apps.append(dayHoroscope)
        dailyHoroscope.apps = apps
        
        //Weekly
        let weeklyHoroscope = AppCategory()
        weeklyHoroscope.name = "Friends Horoscopes"
        
        var wCategoryApps = [App]()
        
        //logic onjects
        let weekHoroscope = App()
        weekHoroscope.name = "Pisces"
        weekHoroscope.detail = "Share"
        weekHoroscope.price = "15-nov ~ 8-Jan"
        weekHoroscope.imageName = #imageLiteral(resourceName: "009-pisces")
        wCategoryApps.append(weekHoroscope)
        
        let weekHoroscope2 = App()
        weekHoroscope2.name = "Libra"
        weekHoroscope2.detail = "Share"
        weekHoroscope2.price = "19-Feb ~ 12-March"
        weekHoroscope2.imageName = #imageLiteral(resourceName: "005-libra")
        wCategoryApps.append(weekHoroscope2)
        
        let weekHoroscope3 = App()
        weekHoroscope3.name = "Leo"
        weekHoroscope3.detail = "Share"
        weekHoroscope3.price = "21-Jun ~ 02-Oct"
        weekHoroscope3.imageName = #imageLiteral(resourceName: "leo")
        wCategoryApps.append(weekHoroscope3)
        
        //News
        var newsFeedPost = AppCategory()
        newsFeedPost.name = "Whats new?"
        
        var newsApps = [App]()
        
        //logic onjects
        let newsPost = App()
        newsPost.name = "Capricorn"
        newsPost.detail = "Today"
        newsPost.price = "Free"
        newsPost.imageName = #imageLiteral(resourceName: "003-capricorn")
        newsApps.append(newsPost)
        newsFeedPost.apps = newsApps
        
        weeklyHoroscope.apps = wCategoryApps
        
       //
        return [dailyHoroscope, weeklyHoroscope, newsFeedPost]
    }
}

class App: NSObject {
    var id: NSNumber?
    var detail:String?
    var imageName:UIImage?
    var name:String?
    var price: String?
    
}
