//
//  DatePickerView.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 9/29/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class FriendHoroscopeView: UIView {
    
    var horoscope: HoroscopeModel? {
        didSet {
            guard let unwrappedPage = horoscope else{return}
            labelTitle.text = unwrappedPage.horoscope
            nameSign.text = unwrappedPage.sign?.uppercased()
            actionBtn.setTitle("Share with your friend", for: .normal)
            
        }
    }
    
    var homeController: ViewController?
    
    let actionBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Share to your friend", for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(handleActionBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let labelTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "Espresso Brown Classic Bristol Rose Gold Watch by Daniel Wellington features contrasting notches display. This classy watch is the perfect finishing touch to any ensemble Watch by Daniel Wellington features contrasting notches display. This classy watch is the perfect finishing touch."
        lbl.textAlignment = .center
        lbl.numberOfLines = 15
        lbl.font = UIFont(name: "JosefinSlab-Regular", size: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let nameSign: UILabel = {
        let lbl = UILabel()
        lbl.text = "Taurus"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 30)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupPicker()
        print("called")
    }
    
    
    
    
    func setupPicker(){
        addSubview(nameSign)
        nameSign.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        nameSign.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nameSign.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameSign.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(labelTitle)
        labelTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        labelTitle.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        addSubview(actionBtn)
        actionBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        actionBtn.centerXAnchor.constraint(equalTo: labelTitle.centerXAnchor).isActive = true
        actionBtn.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        actionBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleActionBtn(){
        print("handle sharing with friend")
        NotificationCenter.default.post(name: NSNotification.Name.bDate, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.shareFriend, object: nil)
    }
    
    
}
