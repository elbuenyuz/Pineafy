//
//  viewControllerTest.swift
//  Pineafy/Users/ElbuenYuz/Documents/Pineafy/Pineafy.xcodeproj
//
//  Created by Daniel Ramirez on 12/4/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
	
	
	let categories = [
		CategoryModel(name: "Business", image: "job", description: "It is never late to find out why your finances are not as expect to be, Find insight with one of our services created by Professional Astrologers."),
		CategoryModel(name: "Money", image: "money", description: "It is never late to find out why your finances are not as expect to be, Find insight with one of our services created by Professional Astrologers."),
		CategoryModel(name: "Relationship", image: "relationship", description: "It is never late to find out why your finances are not as expect to be, Find insight with one of our services created by Professional Astrologers."),
		 CategoryModel(name: "Stuck", image: "stuck", description: "It is never late to find out why your finances are not as expect to be, Find insight with one of our services created by Professional Astrologers.")
	]
	
	var cat = [CategoryModel]()
	
	let descCategory: UILabel = {
		let desc = UILabel()
		desc.font = UIFont(name: "JosefinSlab-Bold", size: 25)
		desc.text = "Select a Category"
		desc.numberOfLines = 10
		desc.textAlignment = .center
		desc.translatesAutoresizingMaskIntoConstraints = false
		return desc
	}()
	
	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
//		layout.scrollDirection = .horizontal
		layout.minimumInteritemSpacing = 20
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.backgroundColor = .clear
		cv.showsVerticalScrollIndicator = false
		cv.translatesAutoresizingMaskIntoConstraints = false
		return cv
	}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = PINK_BG
		collectionView.dataSource = self
		collectionView.delegate = self
	
		collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryId")

    }
	
	override func viewDidAppear(_ animated: Bool) {
	
		fetchCategoryJSON()
	
	}
	
	override func viewWillAppear(_ animated: Bool) {
		setupView()
	}
	
	func setupView(){
		
		self.navigationController?.navigationBar.isTranslucent = true
		self.navigationController?.navigationBar.tintColor = UIColor(red:0.15, green:0.60, blue:0.97, alpha:1.0)
		self.navigationController?.view.backgroundColor = .clear
//		self.navigationController?.navigationBar.prefersLargeTitles = true
		
		view.addSubview(collectionView)
		collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
		collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		
		view.addSubview(descCategory)
		descCategory.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
		descCategory.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		descCategory.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		descCategory.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return categories.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryId", for: indexPath) as! CategoryCell
	
		let category = categories[indexPath.item]
		cell.category = category
		cell.addShadowIcon()
		cell.layer.cornerRadius = 25
		cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let selectCategory = categories[indexPath.item]
		let vc = CategoryDetailVC()
		guard let name = selectCategory.name else { return }
		vc.titleCatgegory = name
		self.navigationController?.pushViewController(vc, animated: true)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: collectionView.frame.width, height: 180)
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		
		return 20
	}
}

extension CategoryVC{
	
	fileprivate func fetchCategoryJSON() {
		print("stsart json")
		let urlJSON = "http://ivanave2.webfactional.com/test/"
		guard let url = URL(string: urlJSON) else { return }
		print("url: \(urlJSON)")
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			
			print("sync")
			DispatchQueue.main.async {
				
				if let err = error{
					print("failed tro obtained data \(err.localizedDescription)")
					return
				}
				guard let data = data else { return }
				
				do{
					let decoder = JSONDecoder()
					self.cat = try decoder.decode([CategoryModel].self, from: data)
					print("data: \(self.cat)")
					self.collectionView.reloadData()
				}catch let jsonError {
					print("json erros")
				}
			}
		}.resume()
	}
}
