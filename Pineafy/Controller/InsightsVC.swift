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
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Daily Insight"
        collectionView?.register(BaseCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .white
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCell
        cell.backgroundColor = .clear
        return cell
    }
    
    func setupCollections(){
        
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("size is changing")
        return CGSize(width: view.frame.width, height: 235)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}


