//
//  FriendVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 11/25/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class FriendVC: UIViewController {
    var horoscope: HoroscopeModel? {
        didSet {
            guard let unwrappedPage = horoscope else{return}
            infoLabel.text = unwrappedPage.horoscope
            dateLabel.text = unwrappedPage.date?.uppercased()
            actionBtn.setTitle("Share with your friend", for: .normal)
            icon.image = unwrappedPage.image
        }
    }
    
    var homeController: ViewController?
    
    let actionBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Share to your friend", for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.backgroundColor = UIColor(red:0.34, green:0.73, blue:0.93, alpha:1.0)
        btn.addShadow()
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(handleActionBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let icon: UIImageView = {
        let sign = UIImageView()
        sign.image = #imageLiteral(resourceName: " Aquarius").withRenderingMode(.alwaysOriginal)
        sign.contentMode = .scaleAspectFit
        sign.translatesAutoresizingMaskIntoConstraints = false
        return sign
    }()
    
    
    let infoLabel: UITextView = {
        let lbl = UITextView()
        let size:CGFloat = 35
		lbl.font = UIFont(name: "JosefinSlab-Light", size: 18)
		lbl.textAlignment = .center
		lbl.isUserInteractionEnabled = true
		lbl.isScrollEnabled = true
		lbl.textAlignment = .justified
		lbl.backgroundColor = PINK_BG
		lbl.sizeToFit()
		lbl.addShadowIcon()
		lbl.isHidden = false
		lbl.adjustsFontForContentSizeCategory = true
		lbl.contentInset = UIEdgeInsets(top: 20, left: 1, bottom: 0, right: 1)
		lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dateLabel: UILabel = {
		let lbl = UILabel()
		//        lbl.backgroundColor = .yellow
		lbl.text = ""
		lbl.textAlignment = .center
		lbl.textColor = UIColor(red:0.49, green:0.35, blue:0.47, alpha:1.0)
		lbl.font = UIFont(name: "JosefinSlab-Light", size: 25)
		lbl.translatesAutoresizingMaskIntoConstraints = false
		return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPicker()
		
    }
	
	override func viewDidAppear(_ animated: Bool) {
		self.navigationController?.navigationBar.topItem?.title = horoscope?.sign
	}
    
    func setupPicker(){
		self.view.backgroundColor = UIColor(red:1.00, green:0.92, blue:0.92, alpha:1.0)
		view.addSubview(icon)
		icon.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
		icon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
		icon.heightAnchor.constraint(equalToConstant: 35).isActive = true
		icon.widthAnchor.constraint(equalToConstant: 35).isActive = true
		
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: self.icon.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true

        view.addSubview(actionBtn)
        actionBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        actionBtn.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: 20).isActive = true
        actionBtn.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: -20).isActive = true
        actionBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: 20).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: -20).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: actionBtn.topAnchor, constant: -10).isActive = true
        
        
        
    }
    
    @objc func handleActionBtn(){
        print("handle sharing with friend")
        NotificationCenter.default.post(name: NSNotification.Name.shareFriend, object: horoscope)
        NotificationCenter.default.post(name: NSNotification.Name.dismiss, object: nil)
        
    }
}
