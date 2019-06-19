//
//  SettingsCell.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 9/7/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class CategoryCell: BaseCell {
	
	//hightlight
	override var isHighlighted: Bool{
		
		didSet{
			backgroundColor = isHighlighted ? UIColor.darkGray: .white
			categoryName.textColor = isHighlighted ? UIColor(red:0.35, green:0.70, blue:0.93, alpha:1.0) : .white
		}
	}
	
	//Creamos un objeto
	var category: CategoryModel? {
		didSet{
			guard let unwrappedCategory = category else {return}
			var image = UIImageView()
			categoryName.text = category?.name
//			bgImage.dowloadFromServer(link: unwrappedCategory.image!)
			guard let txt = unwrappedCategory.image else {return}
			let img = UIImage(named: txt)
			bgImage.image = img
			bgImage.contentMode = .scaleAspectFill
		}
	}
	
	let categoryName: UILabel = {
		let name = UILabel()
		name.font = UIFont(name: "JosefinSlab-SemiBold", size: 25)
		name.text = "namePrueba"
		name.addShadowIcon()
//		name.textColor = .white
		name.textColor = .blue
		name.textAlignment = .center
		name.translatesAutoresizingMaskIntoConstraints = false
		return name
	}()
	
	let bgImage: UIImageView = {
		let icon = UIImageView()
		icon.addShadowIcon()
		icon.image = #imageLiteral(resourceName: "tool")
		icon.backgroundColor = .red
		icon.contentMode = UIViewContentMode.scaleAspectFit
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()
	override func setupViews() {
		self.layer.cornerRadius = 5
		self.layer.masksToBounds = true
		addSubview(bgImage)
		self.backgroundColor = .white
		
		bgImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		bgImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		bgImage.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
		
		bgImage.addSubview(categoryName)
		categoryName.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		categoryName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		categoryName.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
		categoryName.heightAnchor.constraint(equalToConstant: 100).isActive = true
	}
}

extension UIImageView {
	func dowloadFromServer(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() {
				self.image = image
			}
			}.resume()
	}
	func dowloadFromServer(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
		guard let url = URL(string: link) else { return }
		dowloadFromServer(url: url, contentMode: mode)
	}
}

