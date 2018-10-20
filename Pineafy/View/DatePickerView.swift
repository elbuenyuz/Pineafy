//
//  DatePickerView.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 9/29/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class DatePickerView: UIView {
    var homeController: ViewController?
    var date: String?
    
    var spinner : UIActivityIndicatorView = {
        let spin = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)        
        spin.translatesAutoresizingMaskIntoConstraints = false
        return spin
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let actionBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Confirm", for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(handleActionBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let labelTitle: UILabel = {
       let lbl = UILabel()
        lbl.text = "Please confirm your B-Day"
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.font = UIFont(name: "JosefinSlab-Bold", size: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let labelDesc: UILabel = {
        let lbl = UILabel()
        lbl.text = "Description of why we need your bday, easy and clear."
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.font = UIFont(name: "JosefinSlab-Light", size: 23)
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
        addSubview(labelTitle)
        labelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true                
        
        addSubview(datePicker)
        datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(actionBtn)
        actionBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        actionBtn.centerXAnchor.constraint(equalTo: datePicker.centerXAnchor).isActive = true
        actionBtn.widthAnchor.constraint(equalToConstant: 161).isActive = true
        actionBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleActionBtn(){
        print("user date Bday:: \(datePicker.date)")
        NotificationCenter.default.post(name: Notification.Name.bDate, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name.hidden, object: nil)
    }
    
   
}
