//
//  ExploreCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 6/5/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class ServiceCell: UICollectionViewCell {
    
   //connect with the VC to fetch Data
    var exploreCategories: ServiceCategoriesModel? {
        didSet{
            guard let unwrappedCategories = exploreCategories else {return}
            imgView.image = unwrappedCategories.bgImage
            typeLabel.text = unwrappedCategories.nameCategorie
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //items
    let imgView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "bgCell")
        img.addShadowIcon()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 10
        img.clipsToBounds = true
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
    
    let sideView: UIView = {
        let view = UIView()
        return view
    }()
    
    func setupView(){
        self.alpha = 0
        addSubview(imgView)
        imgView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        imgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
  
    }
}


