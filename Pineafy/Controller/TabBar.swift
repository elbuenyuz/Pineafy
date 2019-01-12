//
//  MainVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 1/31/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class TabBar: UIViewController, UITabBarControllerDelegate{
    
    var tabBarCnt: UITabBarController = {
        let bar = UITabBarController()
        return bar
    }()
    
    let menuBar: MenuBar = {
        let bar = MenuBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()

    override func viewDidLoad() {
        setupTabBar()
        presentWalkthrough()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    func setupTabBar(){
        tabBarCnt = UITabBarController()
        tabBarCnt.delegate = self
        tabBarCnt.tabBar.unselectedItemTintColor = UIColor.darkGray
        tabBarCnt.tabBar.addShadow()
        tabBarCnt.tabBar.tintColor = .white
        tabBarCnt.tabBar.barTintColor = UIColor(red:0.40, green:0.31, blue:0.42, alpha:1.0)//vergandie
        tabBarCnt.tabBar.alpha = 1
        tabBarCnt.tabBar.isTranslucent = true
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 11)], for: .normal)
        
//        let pinterestLayout = PinterestLayout()
        let layoutInsight = UICollectionViewFlowLayout()
        
        let layoutAdvisor = UICollectionViewFlowLayout()
        layoutAdvisor.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        //creation of second layout
        let layoutExplorer = UICollectionViewFlowLayout()
        let layoutExplorerServices = UICollectionViewFlowLayout()
        layoutExplorerServices.scrollDirection = .horizontal
        
        
        let isnightVC = UINavigationController(rootViewController: InsightsVC(collectionViewLayout: layoutInsight))
        isnightVC.title = "Insight"
        isnightVC.tabBarItem.image = #imageLiteral(resourceName: "astrologersIcon25px")
        
        let providers = UIViewController()
        providers.title = "Astrologers"
        providers.tabBarItem.image = #imageLiteral(resourceName: "jupiter")
        
        let explore = UINavigationController(rootViewController: ExploreVC(collectionViewLayout: layoutExplorer))
        explore.title = "Explore"
        explore.navigationBar.prefersLargeTitles = false
        explore.tabBarItem.image = #imageLiteral(resourceName: "landingSpace25px")
        
        
        tabBarCnt.viewControllers = [isnightVC,explore]
        self.view.addSubview(tabBarCnt.view)
    }
 
    @objc func handleLogout(){
        print("Handle logOut")
        //force logged in
       

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




