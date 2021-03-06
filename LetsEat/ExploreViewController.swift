//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/6/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
	
	var selectedCity: String? {
		didSet {
			lblLocation.text = selectedCity
		}
	}
	@IBOutlet weak var lblLocation: UILabel!

	@IBOutlet weak var collectionView: UICollectionView!
	let manager = ExploreDataManager()
	
	fileprivate let minItemSpacing: CGFloat = 7
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		initialize()
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier! {
		case Segue.locationList.rawValue:
			showLocationList(segue: segue)
		case Segue.restaurantList.rawValue:
			showRestaurantListing(segue: segue)
		default:
			print("Segue not added")
		}
	}
	
	func initialize() {
		manager.fetch()
		if Device.isPad {
			setupCollectionView()
		}
	}
	
	func setupCollectionView() {
		let flow = UICollectionViewFlowLayout()
		flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
		flow.minimumInteritemSpacing = 0
		flow.minimumLineSpacing = 7
		
		collectionView?.collectionViewLayout = flow
	}
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		if identifier == Segue.restaurantList.rawValue {
			guard selectedCity != nil else {
				showAlert()
				return false
			}
			return true
		}
		return true
	}
	
	func showLocationList(segue: UIStoryboardSegue) {
		guard let navController = segue.destination as? UINavigationController,
			let viewController = navController.topViewController as? LocationViewController else {
				return
		}
		guard let city = selectedCity else {
			return
		}
		viewController.selectedCity = city
		
	}
	
	func showRestaurantListing(segue: UIStoryboardSegue) {
		if let viewController = segue.destination as? RestaurantListViewController,
			let city = selectedCity,
			let index = collectionView.indexPathsForSelectedItems?.first,
			let type = manager.explore(at: index).name {
			
			viewController.selectedType = type
			viewController.selectedCity = city
			
		}
	}
	
	func showAlert() {
		let alertController = UIAlertController(title: "Location Needed", message: "Please select a location", preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default)
		alertController.addAction(okAction)
		present(alertController, animated:  true)
	}
	
	@IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {
		
	}
	
	@IBAction func unwindLocationDone(segue: UIStoryboardSegue) {
		if let viewController = segue.source as? LocationViewController {
			selectedCity = viewController.selectedCity
		}
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		
	}
}


extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if Device.isPad {
			let factor = traitCollection.horizontalSizeClass == .compact ? 2 : 3
			let screenRect = collectionView.frame.size.width
			let screenWith = screenRect - (CGFloat(minItemSpacing) * CGFloat(factor + 1))
			let cellWidth = screenWith / CGFloat(factor)
			return CGSize(width: cellWidth, height: 154)
		} else {
			let screenRect = collectionView.frame.size.width
			let screenWidth = screenRect - 21
			let cellWidth = screenWidth / 2
			return CGSize(width: cellWidth, height: 154)
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return manager.numberOfItems
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell

		let item = manager.explore(at: indexPath)
		if let name = item.name {
			cell.lblName.text = name
		}
		if let image = item.image {
			cell.imgExplore.image = UIImage(named: image)
		}
		
		return cell
	}
}
