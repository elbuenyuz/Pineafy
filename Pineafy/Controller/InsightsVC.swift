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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appCategories = AppCategory.sampleAppCategories()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Daily Insight"
        collectionView?.register(BaseCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCell
        //color change cell
    
        cell.appCategory = appCategories?[indexPath.item]
        return cell
    }
    
    func setupCollections(){
        
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("size is changing")
        return CGSize(width: view.frame.width, height: 200)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count{
            return count
        }
        return 0
    }
    
}


