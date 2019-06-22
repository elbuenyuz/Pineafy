//
//  AvailabilityVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 3/14/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class AdvisorsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let advisorCellId = "advisorCellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        //Registration of collections
        collectionView?.register(AdvisorCell.self, forCellWithReuseIdentifier: advisorCellId)
        self.navigationItem.title = "Astrologers"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //SetUps
        setupCollection()
    }
    
    //Creation array of DInsight Objects
    let advisors = [
            Advisor(name:"",nickName:"CosmicLadySix",rating:"4.7",feedbacks:10,followers:129,description:"I have been an astrologer for 17 years and decided to treat myself to an in-person Lifelong Astrology reading. I found Jamie here onI have been an astrologer for 17 years and decided to treat myself to an in-person Lifelong Astrology reading. I found Jamie here on ",imgProfileUrl: #imageLiteral(resourceName: "u3")),
            Advisor(name:"",nickName:"LastLadyAStrologer",rating:"2.8",feedbacks:20,followers:500,description:"I have had the chance to get three readings with Jamie now, and each have been even more helpful and this is extra space that is used",imgProfileUrl: #imageLiteral(resourceName: "0")),
            Advisor(name:"",nickName:"SisterAstrologer",rating:"4.9",feedbacks:48,followers:50,description:"I had another reading from Jamie. This time we focused on transits. Julie joined us, and really enriched the reading with her perspective.",imgProfileUrl: #imageLiteral(resourceName: "u1"))
        ]
    
    func setupCollection(){
        
        view.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //Collection register and style change
        collectionView?.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        collectionView?.isPagingEnabled = false
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        
    }
    
    //Collection numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advisors.count
    }
    
    //Collection cellForItemAt
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advisorCellId, for: indexPath) as! AdvisorCell
        let advisor = advisors[indexPath.item]
        cell.advisor = advisor
        return cell
    }
    
    
    
    //Collection sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width - 60
        let height:CGFloat = 350
        return CGSize(width:width, height: height)
    }
    
    //Collection minimumLineSpacingForSectionAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    //Function that we provide when our advisor collection is selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc =  DetailInsightVC()// your view controller
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
}
