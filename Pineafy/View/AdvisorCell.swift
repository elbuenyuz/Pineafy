//
//  CalendarCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 1/25/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class AdvisorCell: BaseCell {
    
    let labelName:UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .red
        lbl.text = ""
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imgProfile: UIImageView = {
        let img = UIImageView()
        img.image = nil
        img.backgroundColor = .blue
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        return view
    }()
    
    override func setupViews() {
        addSubview(container)
        
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 8).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 8).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 8).isActive = true
        container.heightAnchor.constraint(equalTo: self.widthAnchor, constant: 8).isActive = true
    }
    
    
}


