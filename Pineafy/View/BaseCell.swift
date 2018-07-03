//
//  BaseCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 1/25/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryItemCell.self, forCellWithReuseIdentifier: categoryCellId)
        
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant:30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive  = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addSubview(nameCollectionCategory)
        nameCollectionCategory.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameCollectionCategory.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        nameCollectionCategory.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameCollectionCategory.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    let nameCollectionCategory: UILabel = {
        let lbl = UILabel()
        lbl.text = "Mercury Return Article somethine"
        lbl.numberOfLines = 2
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection  = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    let categoryCellId = "categoryCellId"
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryItemCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:100, height: frame.width)
    }
}


class CategoryItemCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(itemImage)
        itemImage.backgroundColor = .gray
        itemImage.frame = CGRect(x: 0, y: 100, width: frame.width, height: frame.width)
        addSubview(labelName)
        labelName.frame = CGRect(x: 0, y: frame.width + 102, width: frame.width, height: 30)
        addSubview(categoryLabel)
        categoryLabel.frame = CGRect(x: 0, y: frame.width + 130, width: frame.width, height: 20)
        addSubview(priceLabel)
        priceLabel.frame = CGRect(x: 0, y: frame.width + 150, width: frame.width, height: 20)
    }
    
    private let itemImage: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "u3")
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 20
//        img.clipsToBounds = true
        return img
    }()
    
    let labelName: UILabel = {
        let lbl = UILabel()
        lbl.text = "Mercury Return Article somethine"
        lbl.numberOfLines = 2
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 14)
        return lbl
    }()
    
    let categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Horoscope"
        lbl.font = UIFont(name: "JosefinSlab-Light", size: 13)
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "$45.00"
        lbl.textColor = .darkGray
        lbl.font = UIFont(name: "JosefinSlab-Regular", size: 13)
        return lbl
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
