//
//  MenuBar.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 6/20/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
   
    
    let categoriesArray = [
        CategoryModel(nameCategory:"Money", numberCategory: "1"),
        CategoryModel(nameCategory:"Work", numberCategory: "2"),
        CategoryModel(nameCategory:"Love", numberCategory: "3"),
        CategoryModel(nameCategory:"Relationship", numberCategory: "4"),
        CategoryModel(nameCategory:"Stuck", numberCategory: "5")
        
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //UIcolor UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0) -> gray
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let IdCell = "cellId"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCategoryCell.self, forCellWithReuseIdentifier: IdCell)
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        setupView()
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
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdCell, for: indexPath) as! MenuCategoryCell
        cell.backgroundColor = .black
        cell.categories = categoriesArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
