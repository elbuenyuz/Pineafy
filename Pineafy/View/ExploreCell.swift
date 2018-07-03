//
//  ExploreCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 6/5/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class ExploreCell: UICollectionViewCell {
   //connect with the VC to fetch Data
    var exploreCategories: ExploreCategoriesModel? {
        didSet{
            guard let unwrappedCategories = exploreCategories else {return}
            imgView.image = unwrappedCategories.bgImage
            typeLabel.text = unwrappedCategories.nameCategorie
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor  = .red
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //items
    let imgView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "Banner")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let typeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Relationship"
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 30)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func setupView(){
        addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imgView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        addSubview(typeLabel)
        typeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        typeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        typeLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
