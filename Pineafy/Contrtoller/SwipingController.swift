//
//  SwipingController.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 9/24/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var homeController: ViewController?
    
    let actionBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Let's Start", for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(handleActionBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    private lazy var pageController: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPage  = 0
        pageController.numberOfPages = pages.count
        pageController.currentPageIndicatorTintColor = .red
        pageController.pageIndicatorTintColor = .gray
        return pageController
    }()
    
    //define pages
    let pages = [
        
        Page(bg: #imageLiteral(resourceName: "b1"),image: #imageLiteral(resourceName: "Astrologers"), header: "Pineafy Help You Find Clarity", body: "Pineafy help you find clarity to any situation in your daily life.", showBtn: false),
        Page(bg: #imageLiteral(resourceName: "b2"),image: #imageLiteral(resourceName: "Alignment"), header: "The Big Picture", body: "The best astrologers creating daily insight, with pineafy every day is a new opportunity.", showBtn: false),
        Page(bg: #imageLiteral(resourceName: "b3"),image: #imageLiteral(resourceName: "Planet"), header: "Features", body: "Book situational readings with the best astrologers and find situational clarity, Universe want you to keep moving", showBtn: true)
        
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBtnControlls()
        
        navigationController?.navigationBar.isHidden = true
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        
        collectionView?.backgroundColor = .white
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        
        //didset
        cell.page = page
        
        return cell
    }
    
    
    @objc func handleActionBtn(){
        NotificationCenter.default.post(name: Notification.Name.tabVC, object: nil)
        dismiss(animated: true, completion: nil)
        print("walkthrough dismissed")
    }
    
    fileprivate func setupBtnControlls(){
        actionBtn.isHidden = true
        let bottomControllStackView = UIStackView(arrangedSubviews: [pageController])
        
        view.addSubview(bottomControllStackView)
        
        NSLayoutConstraint.activate([
            bottomControllStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControllStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControllStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControllStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
        bottomControllStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControllStackView.distribution = .fillEqually
        
        view.addSubview(actionBtn)
        actionBtn.bottomAnchor.constraint(equalTo: bottomControllStackView.topAnchor).isActive = true
        actionBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        actionBtn.widthAnchor.constraint(equalToConstant: 161).isActive = true
        actionBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        actionBtn.isUserInteractionEnabled = true
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageController.currentPage = Int(x / view.frame.width)
        print("current fucking page \(pageController.currentPage)")
        
        switch pageController.currentPage {
        case 2:
            
            UIView.animate(withDuration: 2.0, delay: 2.0, options: .transitionCrossDissolve, animations: {
                self.actionBtn.isHidden = false
            }, completion: nil)
            
            
        default:
            actionBtn.isHidden = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageController.currentPage == 0{
                self.collectionView?.contentOffset = .zero
            }else{
                let index = IndexPath(item: self.pageController.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            }
            
        }) { (nil) in
            
        }
    }
}
extension Notification.Name{
    static let tabVC = Notification.Name(rawValue: "tabvc")
    static let bDate = Notification.Name(rawValue: "bdate")
    static let hidden = Notification.Name(rawValue: "hidden")
    static let friend = Notification.Name(rawValue: "friend")
    static let shareFriend = Notification.Name(rawValue: "shareFriend")
}
