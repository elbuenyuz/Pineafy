//
//  PageCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 9/24/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else{return}
            bgImage.image = unwrappedPage.bg
            
            barImageView.image = unwrappedPage.image

            descriptionTextView.text = unwrappedPage.header
            descriptionTitle.text = unwrappedPage.body
            
            descriptionTextView.textAlignment = .center
            descriptionTextView.font = UIFont(name: "JosefinSlab-Bold", size: 35)
            descriptionTitle.font = UIFont(name: "JosefinSlab-Light", size: 23)

        }
    }
    
    let bgImage: UIImageView = {
       let bg = UIImageView()
        bg.image = #imageLiteral(resourceName: "b1")
        bg.contentMode = .scaleToFill
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    private let barImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "insight"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.addShadow()
        return imageView
    }()
    
    let descriptionTextView: UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .white
        textView.textAlignment = .center
        textView.sizeToFit()
        textView.numberOfLines = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let descriptionTitle: UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .white
        textView.sizeToFit()
        textView.numberOfLines = 8
        textView.textAlignment = .center
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        
        setElementsPage()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setElementsPage(){
        addSubview(bgImage)
        bgImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bgImage.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bgImage.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        let topImageContainerView = UIView()
        
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topImageContainerView)
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(barImageView)
        
        barImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        barImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        barImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        barImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: barImageView.bottomAnchor, constant: 20).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addSubview(descriptionTitle)
        descriptionTitle.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 20).isActive = true
        descriptionTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        descriptionTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        descriptionTitle.heightAnchor.constraint(equalToConstant: 200)
        
        
    }
}

extension UIView{
    func addShadow(){
        let graySahdow = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0).cgColor
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = graySahdow
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 2.5
    }
    
    func addShadowIcon(){
        let graySahdow = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0).cgColor
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = graySahdow
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 2.5
    }
}
