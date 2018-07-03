//
//  SwipingController.swift
//  Pineafy
//
//  Created by Daniel Ramirez on 5/4/18.
//  Copyright © 2018 Devius. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let layout = UICollectionViewFlowLayout()
    
    private let previusButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("PREV", for: .normal)
        btn.titleLabel?.font = UIFont(name: "JosefinSlab-Regular", size: 14)
        btn.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let actionBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(red:0.26, green:0.78, blue:0.70, alpha:1.0)
        btn.isOpaque = true
        btn.titleLabel?.font = UIFont(name: "JosefinSlab-Regular", size: 18)
        btn.setTitle("Start Free Insight", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action:#selector(hancleActionBtn), for: .touchUpInside)
        btn.addShadow()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("NEXT", for: .normal)
        btn.titleLabel?.font = UIFont(name: "JosefinSlab-Regular", size: 14)
        btn.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
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
        Page(image: #imageLiteral(resourceName: "Planet"), header: "Daily Free Insight", body: "In this chaotic life we really need to see the big picture of every situation, every day you can find a daily free insight"),
        Page(image: #imageLiteral(resourceName: "Alignment"), header: "Up Coming Planetary Energies", body: "Be aware of up coming energies and don't let nothing stop your goals."),
        Page(image: #imageLiteral(resourceName: "Astrologers"), header: "Personilized Insight", body: "Open your vision to new and daily opportnunities thanks to our personilized insight"),
        Page(image: #imageLiteral(resourceName: "starActivation"), header: "We Like To Help", body: "in Pineafy we care about you and we want to provide valuable resources so you can get the necesary tools to succeed"),
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()       
        setupBtnControlls()
        navigationController?.navigationBar.isHidden = true
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        
        
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
    
    @objc private func handleNext(){
        let nextIndex = min(pageController.currentPage + 1, pages.count - 1)
        let index = IndexPath(item: nextIndex, section: 0)
        pageController.currentPage = nextIndex
        collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handlePrev(){
        let nextIndex = max(pageController.currentPage - 1, 0)
        let index = IndexPath(item: nextIndex, section: 0)
        pageController.currentPage = nextIndex
        collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    @objc func hancleActionBtn(){
       dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupBtnControlls(){
        
        let bottomControllStackView = UIStackView(arrangedSubviews: [previusButton,pageController,nextButton])
                
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
        actionBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        actionBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        actionBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
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
