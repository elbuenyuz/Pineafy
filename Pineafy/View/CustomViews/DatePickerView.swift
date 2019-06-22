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
    
    var formattedDate: String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: datePicker.date)
    }
    
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
        lbl.text = "Confirm your birthday"
        lbl.textAlignment = .center
        lbl.textColor = .red
        lbl.numberOfLines = 1
        lbl.font = UIFont(name: "JosefinSlab-Light", size: 25)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupPicker()
        print("called")
    }
    
    func setupPicker(){
		
		
        addSubview(labelTitle)
        labelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true                
        
        addSubview(datePicker)
        datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -40).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(actionBtn)
        actionBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        actionBtn.centerXAnchor.constraint(equalTo: datePicker.centerXAnchor).isActive = true
        actionBtn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        actionBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleActionBtn(){
        print("user date Bday:: \(formattedDate)")
        let dString = formattedDate
        homeController?.navigationController?.navigationBar.isUserInteractionEnabled = true
        
        NotificationCenter.default.post(name: .bDate, object: dString)
        NotificationCenter.default.post(name: NSNotification.Name.hidden, object: nil)
        
    }
    
   
}
