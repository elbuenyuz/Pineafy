//
//  PageCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 5/4/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else{return}
            barImageView.image = unwrappedPage.image
            
            
            let attributeText = NSMutableAttributedString(string: unwrappedPage.header, attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-Bold", size: 25)])
            descriptionTextView.text = unwrappedPage.header
           
            
            //second Text
            attributeText.append(NSMutableAttributedString(string: "\n\n\n \(unwrappedPage.body)", attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-Light", size: 20)]))
            
            descriptionTextView.attributedText = attributeText
            descriptionTextView.textAlignment = .center
            
        }
    }
    
    private let barImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Planet"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.addShadow()
        return imageView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .white
        textView.addShadow()
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
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        
        
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

