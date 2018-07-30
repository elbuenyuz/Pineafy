//
//  BaseCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 1/25/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var appCategory: AppCategory? {
        didSet{
            guard let unwrappedCategory = appCategory else { return }
                nameCollectionCategory.text = unwrappedCategory.name
                
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        print("entrando a la collection")
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
        nameCollectionCategory.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        nameCollectionCategory.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        nameCollectionCategory.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nameCollectionCategory.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    let nameCollectionCategory: UILabel = {
        let lbl = UILabel()
        lbl.text = "title"
        lbl.numberOfLines = 2
        lbl.backgroundColor = UIColor(red:0.45, green:0.44, blue:0.66, alpha:1.0)
        lbl.addShadow()
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 25)
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
         if let count = appCategory?.apps?.count{
            return count
            print("checando cuantos apps")
        }
        return 0
    }
    let categoryCellId = "categoryCellId"
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellId, for: indexPath) as! CategoryItemCell
        
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //resize the inside cell of the baseCell
        return CGSize(width:100, height: frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


class CategoryItemCell: UICollectionViewCell {
    var app: App? {
        didSet{
            guard let unwrapped = app else { return }
            labelName.text = unwrapped.name
            itemImage.image = unwrapped.imageName
            priceLabel.text = unwrapped.price
            categoryLabel.text = unwrapped.detail
            print("entra :)")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(itemImage)
        itemImage.backgroundColor = .clear
        itemImage.frame = CGRect(x: 0, y: 120, width: frame.width, height: frame.width)
        addSubview(labelName)
      
        labelName.frame = CGRect(x: 0, y: frame.width + 122, width: frame.width, height: 15)
        addSubview(categoryLabel)
        categoryLabel.frame = CGRect(x: 0, y: frame.width + 136, width: frame.width, height: 15)
        addSubview(priceLabel)
        priceLabel.frame = CGRect(x: 0, y: frame.width + 151, width: frame.width, height: 15)
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
        lbl.textAlignment = .center
        lbl.addShadow()
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 18)
        return lbl
    }()
    
    let categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Horoscope"
        lbl.textAlignment = .center
        lbl.addShadow()
        lbl.textColor = _ZION
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 15)
        return lbl
    }()
    
    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "$45.00"
        lbl.textAlignment = .center
        lbl.addShadow()
        lbl.textColor = .darkGray
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 15)
        return lbl
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
