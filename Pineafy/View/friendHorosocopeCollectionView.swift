//
//  friendHoroscopeMenu.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 10/3/18.
//  Copyright © 2018 Devius. All rights reserved.
//
//  MenuBar.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 6/20/18.
//  Copyright © 2018 Devius. All rights reserved.
//
import UIKit

class FriendHorosocopeCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    
    
    var homeController:ViewController?
    var categoriesArray : [HoroscopeModel]?
    
    lazy var collectionView: UICollectionView = {
        let zion = UIColor(red:0.53, green:0.35, blue:0.55, alpha:1.0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        //UIcolor UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0) -> gray
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let IdCell = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(friendHoroscopeCell.self, forCellWithReuseIdentifier: IdCell)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        setupView()
    }
    
    func setupHoroscopes(array: [HoroscopeModel]){
        categoriesArray = []
        print("been added\(array.count)")
        categoriesArray = array
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    //CollectionViewControllers
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return (categoriesArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell, for: indexPath) as! friendHoroscopeCell
        cell.categories = categoriesArray![indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("isSelected")
        NotificationCenter.default.post(name: NSNotification.Name.friend, object: nil)

    }

}

