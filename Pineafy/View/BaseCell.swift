//
//  BaseCell.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 1/25/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

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
