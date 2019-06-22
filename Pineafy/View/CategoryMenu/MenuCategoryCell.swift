//
//  MenuCategoryCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 7/3/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class MenuCategoryCell: UICollectionViewCell {
 
    //connect with the VC to fetch Data
    var categories: CategoryModel? {
        didSet{
            guard let unwrappedCategories = categories else {return}
            //Setup Values UI
            nameCategory.text = unwrappedCategories.nameCategory
            
        }
    }
    override var isHighlighted: Bool {
        didSet{
            self.backgroundColor = isHighlighted ? _STRONG_ZION : _STRONG_ZION
            nameCategory.textColor = isHighlighted ? UIColor.white : UIColor.black
            nameCategory.backgroundColor = isHighlighted ? UIColor(red:0.40, green:0.31, blue:0.42, alpha:1.0) : _ZION
            
        }
    }
    
    override var isSelected: Bool {
        didSet{
            self.backgroundColor = isSelected ? _STRONG_ZION : _STRONG_ZION
            nameCategory.textColor = isSelected ? UIColor.white : UIColor.black
            nameCategory.backgroundColor = isSelected ? UIColor(red:0.40, green:0.31, blue:0.42, alpha:1.0) : _ZION
            
        }
    }
    
    let nameCategory: UILabel = {
        let name = UILabel()
        name.text = "Money"
        name.textAlignment = .center
        name.textColor = .white
        name.font = UIFont(name: "JosefinSlab-Bold", size: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        nameCategory.textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        
        addSubview(nameCategory)
        nameCategory.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameCategory.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        nameCategory.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

    }
}
