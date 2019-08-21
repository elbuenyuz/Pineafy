//
//  BookingVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 5/11/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import Foundation
import UIKit

class BookingVC: UIViewController {
	let stack = UIStackView()
	let scrollView: UIScrollView = {
		let scroll = UIScrollView()
//		let screensize: CGRect = UIScreen.main.bounds
//		let screenWidth = screensize.width
//		let screenHeight = screensize.height
//		scroll.contentSize = CGSize(width: screenWidth, height: screenHeight)
		scroll.backgroundColor = .white
		scroll.translatesAutoresizingMaskIntoConstraints = false
		return scroll
	}()
	
	let providerCard: UIView = {
		let view = UIView()
		view.backgroundColor = .red
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		setupView()
	}
	
	
	func setupView(){
		
		view.addSubview(scrollView)
		scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		
		stack.addSubview(providerCard)
		scrollView.addSubview(providerCard)
		
		
	}
}
