//
//  Services.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 3/14/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class InsightsVC: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    let cellId = "cellId"
    var appCategories:[AppCategory]?
    let blackView = UIView()
    
    let serviceView: DetailServiceView = {
        let view = DetailServiceView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appCategories = AppCategory.sampleAppCategories()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Daily Insight"
        collectionView?.register(BaseCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 0,0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCell
        //color change cell
    
        cell.appCategory = appCategories?[indexPath.item]
        return cell
    }
    
    //Show DetailInformation
    func showSettings(){
        print("show settings")
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
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("size is changing")
        return CGSize(width: view.frame.width, height: 220)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count{
            return count
        }
        return 0
    }
    
}


