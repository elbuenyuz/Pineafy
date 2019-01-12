//
//  ExploreVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 6/5/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class ExploreVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let blackView = UIView()
    let identifier = "CellId"
    
    var appCategories: [AppCategory]?
    
    let menuBar: MenuBar = {
        let menu = MenuBar()
        menu.backgroundColor = .white        
        menu.translatesAutoresizingMaskIntoConstraints = false
        return menu
    }()
    
    let serviceView: DetailServiceView = {
        let view = DetailServiceView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var exploreCategories = [
        
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "chida2"), nameCategorie: "Money"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "chida2"), nameCategorie: "Love"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "cleanBg"), nameCategorie: "Future"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "cleanBg"), nameCategorie: "Family"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "chida2"), nameCategorie: "Past"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "cleanBg"), nameCategorie: "Work")
    ]
    
    let exploreCategories2 = [
        
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "chida"), nameCategorie: "Money"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "chida2"), nameCategorie: "Love"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "cleanBg"), nameCategorie: "Future"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "cleanBg"), nameCategorie: "Family"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "chida2"), nameCategorie: "Past"),
        ServiceCategoriesModel(bgImage: #imageLiteral(resourceName: "cleanBg"), nameCategorie: "Work")
    ]
    
    var tableViewRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        
        refreshControl.tintColor = .gray
        refreshControl.frame(forAlignmentRect: .zero)
        refreshControl.addTarget(self, action: #selector(refreshCollection), for: .valueChanged)
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        setupMenuItems()
        
        //notificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(loadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        view.backgroundColor = UIColor(red:0.99, green:0.95, blue:0.99, alpha:1.0)//clarito
        navigationItem.title = "Explore"
        navigationController?.navigationBar.isHidden = false
        collectionView?.register(ServiceCell.self, forCellWithReuseIdentifier: identifier)
        collectionView?.refreshControl = tableViewRefreshControl
        collectionView?.contentInset = UIEdgeInsetsMake(55, 0, 10,0)
        
    }
    
    
    @objc func refreshCollection(){
        
        self.collectionView?.reloadData()
        self.tableViewRefreshControl.endRefreshing()
    }
    
    @objc func loadList(notification: NSNotification) {
        self.collectionView?.performBatchUpdates(
            {
                exploreCategories.append(exploreCategories2[0])
                self.collectionView?.reloadSections(NSIndexSet(index: 0) as IndexSet)
                
        }, completion: { (finished:Bool) -> Void in
        })
    }
    
    private func setupMenuItems(){
        
        let toolsBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "tools"), style: .plain, target: self, action: #selector(handleToolAction))
        navigationItem.rightBarButtonItems = [toolsBtn]
        toolsBtn.tintColor = .white
    }
    
    @objc private func handleToolAction(){
        print("Action")
    }
    
    private func setupMenuBar(){
        menuBar.backgroundColor = .red
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //        collectionView?.isHidden = true
        collectionView?.backgroundColor = UIColor(red:0.99, green:0.95, blue:0.99, alpha:1.0)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: -40).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo:  view.trailingAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exploreCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ServiceCell
        let service = exploreCategories[indexPath.item]
        cell.exploreCategories = service
        cell.addShadow()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showSettings()
    }
    
    
    
    //Show DetailInformation
    func showSettings(){
        
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handledismissBlackView)))
            
            window.addSubview(blackView)
            window.addSubview(serviceView)
            
            //collectionV
            let heigth: CGFloat = window.frame.height - 100
            //modificar posicion inicial de la colleccion
            serviceView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width - 20, height: heigth)
            
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            //animation
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.serviceView.frame = CGRect(x: window.frame.width/2 - self.serviceView.frame.width/2, y: window.frame.height - heigth - 30, width: self.serviceView.frame.width, height: self.serviceView.frame.height - 80)
                
            }, completion: nil)
        }
    }
    
    
    @objc func handledismissBlackView(){
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:.curveEaseOut, animations: {
            self.blackView.alpha = 0
            let heigth: CGFloat = 400
            if let window = UIApplication.shared.keyWindow{
                
                self.serviceView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: heigth)
                
                
            }
            
        }) { (completed: Bool) in
            
        }
    }
}

















