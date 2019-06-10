//
//  friendHorosocpeCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 10/3/18.
//  Copyright © 2018 Devius. All rights reserved.
//
import UIKit

class friendHoroscopeCell: UICollectionViewCell {
    
    //connect with the VC to fetch Data
    var categories: HoroscopeModel? {
        didSet{
            guard let unwrappedCategories = categories else {return}
            //Setup Values UI
            nameHoroscope.text = unwrappedCategories.sign
            imageHoroscope.image = unwrappedCategories.image
            
        }
    }
    override var isHighlighted: Bool {
        didSet{
            self.backgroundColor = isHighlighted ? .white : UIColor(red:1.00, green:0.92, blue:0.92, alpha:1.0)
            nameHoroscope.textColor = isHighlighted ? UIColor.white : UIColor.black
            nameHoroscope.backgroundColor = isHighlighted ? .black : UIColor(red:1.00, green:0.92, blue:0.92, alpha:1.0)

        }
    }
//
//    override var isSelected: Bool {
//        didSet{
//            self.backgroundColor = isSelected ? .white : .white
//            nameHoroscope.textColor = isSelected ? UIColor.white : UIColor.black
//            nameHoroscope.backgroundColor = isSelected ? UIColor(red:0.40, green:0.31, blue:0.42, alpha:1.0) : .white
//
//        }
//    }
    
    let nameHoroscope: UILabel = {
        let name = UILabel()
        name.text = "Money"
        name.textAlignment = .center
        name.textColor = .white        
        name.font = UIFont(name: "JosefinSlab-Bold", size: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    var imageHoroscope: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: " Scorpio")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = UIColor(red:1.00, green:0.92, blue:0.92, alpha:1.0)
        nameHoroscope.textColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        
        addSubview(imageHoroscope)
        imageHoroscope.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageHoroscope.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageHoroscope.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageHoroscope.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(nameHoroscope)
        nameHoroscope.bottomAnchor.constraint(equalTo: imageHoroscope.topAnchor).isActive = true
        nameHoroscope.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameHoroscope.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        nameHoroscope.heightAnchor.constraint(equalToConstant: 30).isActive = true  
    }
}
