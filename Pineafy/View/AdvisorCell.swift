//
//  CalendarCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 1/25/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class AdvisorCell: UICollectionViewCell {
    
    var advisor: Advisor? {
        didSet {
            guard let unwrappedAdvisor = advisor else{return}
            
            imgProfile.image = unwrappedAdvisor.imgProfileUrl //change img
            labelName.text = unwrappedAdvisor.nickName
            attributeSetUp(unwrappedAdvisor: unwrappedAdvisor)
            descriptionTextView.text = "\"\(unwrappedAdvisor.description)\""
        }
    }
    
    
    
    private let labelName:UITextView = {
        let lbl = UITextView()
        lbl.text = "CosmicLadySix"
        lbl.textColor = .gray
        lbl.isUserInteractionEnabled = false
        lbl.textAlignment = .center
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
   private let imgProfile: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "0")
        img.layer.cornerRadius = 50
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.backgroundColor = .clear
        return view
    }()
    
    private let firstBadge: UIImageView = {
        let badge = UIImageView()
        badge.image = #imageLiteral(resourceName: "medal-icon-18")
        badge.contentMode = .scaleAspectFit
        badge.translatesAutoresizingMaskIntoConstraints = false
        return badge
    }()
    
    private let feedbacks: UITextView = {
        let feedback = UITextView()
        feedback.text = "127K Feedbacks"
        feedback.textAlignment = .center
        feedback.isUserInteractionEnabled = false
        feedback.layer.borderColor = UIColor.gray.cgColor
        feedback.layer.borderWidth = 0.5
        feedback.backgroundColor = .purple
        
        feedback.translatesAutoresizingMaskIntoConstraints = false
        return feedback
    }()
    
    private let rating: UITextView = {
        let rate = UITextView()
        rate.text = "Rating : 4.7"
        rate.textAlignment = .center
        rate.isUserInteractionEnabled = false
        rate.layer.borderColor = UIColor.gray.cgColor
        rate.layer.borderWidth = 0.5
        rate.backgroundColor = .purple
        rate.translatesAutoresizingMaskIntoConstraints = false
        return rate
    }()

    let bookBtn: UILabel = {
        let btn = UILabel()
        btn.text = "LEARN MORE"
        btn.textColor = .white
        btn.layer.cornerRadius = 5
        btn.font = UIFont(name: "JosefinSlab-Thin", size: 20)
        btn.textAlignment = .center
        btn.backgroundColor = UIColor(red:0.31, green:0.80, blue:0.76, alpha:1.0)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let descriptionTextView: UITextView = {
        let txtView = UITextView()
        txtView.text = "description"
        txtView.textAlignment = .center
        txtView.sizeToFit()
        txtView.isUserInteractionEnabled = false
        txtView.font = UIFont(name: "JosefinSlab-SemiBoldItalic", size: 14)
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()
    
    fileprivate func setupBtnControlls(){
        let bottomControllStackView = UIStackView(arrangedSubviews: [feedbacks,firstBadge,rating])
        
       self.addShadow()
        
        addSubview(bookBtn)
        bookBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bookBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bookBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bookBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(container)
        container.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: bookBtn.topAnchor).isActive = true
        
        addSubview(imgProfile)
        imgProfile.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        imgProfile.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        imgProfile.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imgProfile.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(labelName)
        labelName.topAnchor.constraint(equalTo: imgProfile.bottomAnchor).isActive = true
        labelName.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        labelName.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        labelName.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(bottomControllStackView)
        NSLayoutConstraint.activate([
            bottomControllStackView.topAnchor.constraint(equalTo: labelName.bottomAnchor),
            bottomControllStackView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            bottomControllStackView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            bottomControllStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        bottomControllStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControllStackView.distribution = .fillEqually
        
        
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: bottomControllStackView.bottomAnchor, constant: 5).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -5).isActive = true
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupBtnControlls()
        self.layer.cornerRadius  = 5
        
        
    }
    
    func attributeSetUp(unwrappedAdvisor: Advisor){
        //attribute labelName
        let attributeText3 = NSMutableAttributedString(string:"\(unwrappedAdvisor.nickName)", attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-Bold", size: 25)])
        labelName.text = "\(unwrappedAdvisor.nickName)"
        
        //second Text
        attributeText3.append(NSMutableAttributedString(string: "\nAstrologer", attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-LightItalic", size: 15)]))
        labelName.attributedText = attributeText3
        labelName.textAlignment = .center
        labelName.textColor = .purple
        
        
        //attribute feedback
        let attributeText = NSMutableAttributedString(string:"\(unwrappedAdvisor.feedbacks)", attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-Bold", size: 20)])
        feedbacks.text = "\(unwrappedAdvisor.followers)"
        
        //second Text
        attributeText.append(NSMutableAttributedString(string: "\nFeedbacks", attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-Regular", size: 15)]))
        feedbacks.attributedText = attributeText
        feedbacks.textAlignment = .center
        feedbacks.textColor = .yellow
        feedbacks.textAlignment = .center
 
        
        //attribute rating
        //attribute
        let attributeText2 = NSMutableAttributedString(string:"\(unwrappedAdvisor.rating)", attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-Bold", size: 20)])
        rating.text = "\(unwrappedAdvisor.rating)"
        
        //second Text
        attributeText2.append(NSMutableAttributedString(string: "\nRating", attributes: [ NSAttributedStringKey.font : UIFont(name: "JosefinSlab-Regular", size: 15)]))
        
        rating.attributedText = attributeText2
        rating.textAlignment = .center
        rating.textColor = .yellow
        rating.textAlignment = .center

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


