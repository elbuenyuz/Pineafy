//
//  Services.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 3/14/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import AVKit

class ServicesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collection.dequeueReusableCell(withReuseIdentifier: "sCell", for: indexPath) as! DailyInsightCell
        
        return cell
    }
    
    let cellHeight: CGFloat = 200
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width/2, height: cellHeight)
    }
    
    let serName: UITextField = {
        let name = UITextField()
        return name
    }()
    
    let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.layer.borderColor = UIColor.lightGray.cgColor
        cv.alpha = 0.9
        cv.isScrollEnabled = false
        cv.layer.cornerRadius = 5
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    //elements

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Services"
        
        setupView()
        collection.register(DailyInsightCell.self, forCellWithReuseIdentifier: "sCell")
        collection.delegate = self
        collection.dataSource = self
        
        //Register
       
    }
    
    func setupView(){
        
        view.addSubview(collection)
        collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        collection.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collection.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collection.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
}


