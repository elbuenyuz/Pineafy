//
//  FourStepsVC.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 6/13/19.
//  Copyright © 2019 Devius. All rights reserved.
//

import Foundation
import UIKit

class FourStepsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
	
	
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.minimumInteritemSpacing = 20
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.isPagingEnabled = true
		cv.showsHorizontalScrollIndicator = false
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.register(FirstStepCell.self, forCellWithReuseIdentifier: FIRST_STEP_ID_CELL)
		view.backgroundColor = .white
		collectionView.delegate = self
		collectionView.dataSource = self
		setupView()
	}
	override func viewDidAppear(_ animated: Bool) {
		MoveToNextCell()
	}
	
	func setupView(){
		view.addSubview(collectionView)
		collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 4
	}
	
	
	// make a cell for each cell index path
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FIRST_STEP_ID_CELL, for: indexPath) as! FirstStepCell
		
		cell.name.becomeFirstResponder()
		
		return cell
	}
	
	
	// MARK: - UICollectionViewDelegate protocol
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// handle tap events
		print("You selected cell #\(indexPath.item)!")
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: self.view.frame.width , height: self.view.frame.height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		
		return 1.0
	}
	
	func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 1.0
	}

	func MoveToNextCell(){
	
	let collectionBounds = self.collectionView.bounds
	let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
	self.moveToCell(contentOffset: contentOffset)
	}
	
	func moveToPreviousCell(){
		let collectionBounds = self.collectionView.bounds
		let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
		self.moveToCell(contentOffset: contentOffset)
	}
	
	func moveToCell(contentOffset: CGFloat){
		let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
		self.collectionView.scrollRectToVisible(frame, animated: true)
	}
}
