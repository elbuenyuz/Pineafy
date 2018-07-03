//
//  ExploreVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 6/5/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class ExploreVC: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
   
    let menuBar: MenuBar = {
        let menu = MenuBar()
        menu.backgroundColor = .white        
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    let exploreCategories = [
    
        ExploreCategoriesModel(bgImage: #imageLiteral(resourceName: "Banner"), nameCategorie: "Love"),
        ExploreCategoriesModel(bgImage: #imageLiteral(resourceName: "Banner2"), nameCategorie: "Work"),
        ExploreCategoriesModel(bgImage: #imageLiteral(resourceName: "Banner3"), nameCategorie: "Money"),
        ExploreCategoriesModel(bgImage: #imageLiteral(resourceName: "Banner4"), nameCategorie: "Feeling Stuck"),
        ExploreCategoriesModel(bgImage: #imageLiteral(resourceName: "Banner"), nameCategorie: "Family"),
        ExploreCategoriesModel(bgImage: #imageLiteral(resourceName: "Banner2"), nameCategorie: "Future"),
        ExploreCategoriesModel(bgImage: #imageLiteral(resourceName: "Banner3"), nameCategorie: "Past")
    ]

        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        setupCollection()
        setupMenuItems()
        navigationItem.title = "Explore"
        navigationController?.navigationBar.isHidden = false
        collectionView?.register(ExploreCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        collectionView?.contentInset = UIEdgeInsetsMake(5, 0, 0, 0)
    }
    
    private func setupMenuItems(){
        let toolsBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "tools"), style: .plain, target: self, action: #selector(handleToolAction))
        navigationItem.rightBarButtonItems = [toolsBtn]
    }
    
    @objc private func handleToolAction(){
        print("Action")
    }
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupCollection(){
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ExploreCell
        let categorie = exploreCategories[indexPath.item]
        cell.exploreCategories = categorie
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let vc =  AdvisorsVC(collectionViewLayout: layout)// your view controller
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
