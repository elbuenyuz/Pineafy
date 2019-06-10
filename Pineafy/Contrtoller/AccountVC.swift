//
//  AccountVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 3/1/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import UIKit

class AccountVC: UITableViewController {
    let accountItems = ["Edit Birthday","Register"]
    var homeController: ViewController?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.navigationController?.navigationBar.topItem?.title = "Account"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.backgroundColor = .gray
        tableView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        
        tableView.register(AccountCell.self, forCellReuseIdentifier: KEY_ACCOUNT_CELLID)
        self.view.backgroundColor = .white
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accountItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KEY_ACCOUNT_CELLID, for: indexPath)
        cell.textLabel?.text = accountItems[indexPath.item]
        cell.textLabel?.textColor = .blue
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("account:\(accountItems[indexPath.item])")
        
        let name = accountItems[indexPath.item]
        
        switch name {
        case "Edit Birthday":
            print("edit birthday")
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                 self.navigationController?.popToRootViewController(animated: true)
            }) { (true) in
               NotificationCenter.default.post(name:.tabVC, object: nil)
            }
            
        case "Register":
            print("Register")
            
            UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                
                self.navigationController?.popToRootViewController(animated: true)
            }) { (true) in
                NotificationCenter.default.post(name:.register, object: nil)
            }
        default:
            break;
        }
    }
}
