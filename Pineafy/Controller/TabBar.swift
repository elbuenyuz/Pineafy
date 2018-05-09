//
//  MainVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 1/31/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit
import FirebaseAuth



class TabBar: UIViewController, UITabBarControllerDelegate{
    var tabBarCnt: UITabBarController = {
        let bar = UITabBarController()
        return bar
    }()

    override func viewDidLoad() {
        setupNavBar()
        presentWalkthrough()
        setupTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser?.uid == nil{
//            perform(#selector(handleLogout), with: nil, afterDelay: 0)
//        }
        
    }
    
    //setups
    private func setupNavBar(){
        view.backgroundColor = .white
        self.navigationItem.title = "Hi Daniel "
        
        let menuBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        self.navigationItem.leftBarButtonItem  = menuBtn
    }
    
    func setupTabBar(){
        tabBarCnt = UITabBarController()
        tabBarCnt.delegate = self
        
        tabBarCnt.tabBar.tintColor = .gray
        tabBarCnt.tabBar.barTintColor = .white
        tabBarCnt.tabBar.alpha = 0.9
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 11)], for: .normal)
    
        
        let layout = PinterestLayout()
        let dInsight = DailyInsightVC(collectionViewLayout: layout)
        let retention = dInsight
        retention.title = "Insight"
        retention.tabBarItem.image = #imageLiteral(resourceName: "astrologersIcon25px")
        
        
        let providers = UIViewController()
        providers.title = "Astrologers"
        providers.tabBarItem.image = #imageLiteral(resourceName: "jupiter")
        
        
        let services = UIViewController()
        services.title = "Services"
        services.tabBarItem.image = #imageLiteral(resourceName: "landingSpace25px")
        
        
        tabBarCnt.viewControllers = [retention,providers,services]
        self.view.addSubview(tabBarCnt.view)
    }
 
    @objc func handleLogout(){
        print("Handle logOut")
        //force logged in
        do{
            try Auth.auth().signOut()

        }catch let logoutError {
            print(logoutError)
        }

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    private func presentWalkthrough(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let myCollectionVC = SwipingController(collectionViewLayout: layout)
        
        navigationController?.present(myCollectionVC, animated: true, completion: nil)        
    }
}



extension UIButton {
    
    func addShadow(){
        let graySahdow = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0).cgColor
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = graySahdow
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 2.5
    }
}
