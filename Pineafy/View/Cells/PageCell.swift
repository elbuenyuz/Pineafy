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
        
            descriptionTextView.text = unwrappedPage.header
            descriptionText.text = unwrappedPage.body
            
            descriptionTextView.textAlignment = .left
            descriptionTextView.font = UIFont(name: "JosefinSlab-Bold", size: 40)
            descriptionText.font = UIFont(name: "JosefinSlab-Regular", size: 28)

        }
    }
    
    let bgImage: UIImageView = {
       let bg = UIImageView()
        bg.image = #imageLiteral(resourceName: "b1")
        bg.contentMode = .scaleToFill
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    let descriptionTextView: UILabel = {
        let textView = UILabel()
        textView.alpha = 1.0
        textView.sizeToFit()
        textView.addShadowText()
        textView.textColor = UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
        textView.numberOfLines = 3
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let descriptionText: UILabel = {
        let textView = UILabel()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.sizeToFit()
        textView.numberOfLines = 8
        textView.textAlignment = .left
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let container: UIView = {
        let cv = UIView()
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
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
        
        addSubview(container)
        container.centerXAnchor.constraint(equalTo: self.bgImage.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: self.bgImage.centerYAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.bgImage.widthAnchor, constant: -60).isActive = true
        container.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        container.addSubview(descriptionTextView)
        descriptionTextView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        descriptionTextView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        descriptionTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        container.addSubview(descriptionText)
        descriptionText.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 10).isActive = true
        descriptionText.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        descriptionText.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        descriptionText.heightAnchor.constraint(equalToConstant: 200)
        
        
    }
}

extension UIView{
    func addShadow(){
        let graySahdow = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0).cgColor
        
        self.layer.shadowOffset = CGSize(width: 1, height: 0.5)
        self.layer.shadowColor = graySahdow
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 2.5
    }
    
    func addShadowText(){
        let graySahdow = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1.0).cgColor
    
        self.layer.shadowOffset = CGSize(width: 0.5, height:0.5)
        self.layer.shadowColor = graySahdow
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 1
    }
    
    func addShadowIcon(){
        
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0).cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
    }
}
