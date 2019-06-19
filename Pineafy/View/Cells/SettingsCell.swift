//
//  SettingsCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    //hightlight
    override var isHighlighted: Bool{
       
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray: .white
            settingName.textColor = isHighlighted ? .white : UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
            
            if settingName.text == "Marketplace"{
                settingName.textColor = isHighlighted ? UIColor(r: 97, g: 212, b: 232) : UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
            }
        }
    }
    
    //Creamos un objeto
    var setting: SettingMenuModel? {
        didSet{
            self.settingName.text = setting?.name
            guard let img = setting?.imgName else { return }
            self.iconImage.image = UIImage(named: img)
        }
    }
    
    let settingName: UILabel = {
        let name = UILabel()
        name.font = UIFont(name: "Dosis-Medium", size: 17)
        name.text = "namePrueba"
        name.addShadowIcon()
        name.textColor = UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0)
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let iconImage: UIImageView = {
        let icon = UIImageView()
        icon.addShadowIcon()
        icon.image = #imageLiteral(resourceName: "tool").withRenderingMode(.alwaysOriginal)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    override func setupViews() {
        addSubview(settingName)
        addSubview(iconImage)
        
        settingName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        settingName.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        settingName.widthAnchor.constraint(equalToConstant: 120).isActive = true
        settingName.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        iconImage.rightAnchor.constraint(equalTo: settingName.leftAnchor, constant: -8).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

