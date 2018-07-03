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
            self.backgroundColor = isHighlighted ? UIColor.white : UIColor.black
            nameCategory.textColor = isHighlighted ? UIColor.black : UIColor.white
            selectedLine.backgroundColor = isHighlighted ? UIColor.black : .white
            
        }
    }
    
    override var isSelected: Bool {
        didSet{
            self.backgroundColor = isSelected ? UIColor.white : UIColor.black
            nameCategory.textColor = isSelected ? UIColor.black : UIColor.white
            selectedLine.backgroundColor = isSelected ? UIColor.black : .white
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
    
    let selectedLine: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(selectedLine)
        selectedLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        selectedLine.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        selectedLine.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        selectedLine.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        addSubview(nameCategory)
        nameCategory.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameCategory.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        nameCategory.bottomAnchor.constraint(equalTo: self.selectedLine.topAnchor).isActive = true
    }
}
