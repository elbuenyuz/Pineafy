//
//  AvailabilityVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 3/14/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class DailyInsightVC: UICollectionViewController, PinterestLayoutDelegate{
    
//    Mark: ~ Objects
    let loadTitle: UILabel = {
        let title = UILabel()
        title.text = "Loading..."
        return title
    }()
    
    let indicator: UIActivityIndicatorView = {
        let inView = UIActivityIndicatorView()
        return inView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let layout =  collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //Collection register and style change
        collectionView?.backgroundColor = .white
        collectionView?.register(DailyInsightCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView?.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    //Creation array of DInsight Objects
    let dInsight = [
        DailyInsight(img:#imageLiteral(resourceName: "image-6")),
        DailyInsight(img:#imageLiteral(resourceName: "image-4")),
        DailyInsight(img:#imageLiteral(resourceName: "image-1")),
        DailyInsight(img:#imageLiteral(resourceName: "image-3")),
        DailyInsight(img:#imageLiteral(resourceName: "image-6")),
        DailyInsight(img:#imageLiteral(resourceName: "image-4")),
        DailyInsight(img:#imageLiteral(resourceName: "image-1")),
        DailyInsight(img:#imageLiteral(resourceName: "image-3")),
        DailyInsight(img:#imageLiteral(resourceName: "image-2"))
        
    ]
    
    //Collection numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dInsight.count
    }
    
    //Collection cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! DailyInsightCell
        let insight = dInsight[indexPath.item]
        cell.dInsight = insight
        return cell
    }
    
    //Collection sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let image = dInsight[indexPath.item].img
        let height = image.size.height
        
        return height
    }
    
    
    //Collection minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
}
