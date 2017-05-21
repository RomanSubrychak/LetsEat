//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import LetsEatDataKit

class RestaurantListViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	
	let manager = RestaurantDataManager()
	
	
	var selectedRestaurant: RestaurantItem?
	var selectedCity: String?
	var selectedType: String?
		
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		guard let location = selectedCity, let type = selectedType else {
			return
		}
		manager.fetch(by: location,withFilter: type, completionHandler: collectionView.reloadData)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier! {
		case Segue.showDetail.rawValue:
			showRestaurantDetail(segue: segue)
		default:
			print("segue not added")
		}
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		collectionView.reloadData()
	}
	
	func initialize() {
		if Device.isPad {
			setupCollectionView()
		}
		setup3DTouch()
	}
	
	func setupCollectionView() {
		let flow = UICollectionViewFlowLayout()
		
		flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
		flow.minimumInteritemSpacing = 0
		flow.minimumLineSpacing = 7
		collectionView.collectionViewLayout = flow
		
	}
	
	func showRestaurantDetail(segue: UIStoryboardSegue) {
		if let viewController = segue.destination as? RestaurantDetailViewController, let index = collectionView.indexPathsForSelectedItems?.first {
			selectedRestaurant = manager.restaurantItem(at: index)
			viewController.selectedRestaurant = selectedRestaurant
		}
	}
	
	func setup3DTouch() {
		if traitCollection.forceTouchCapability == .available {
			registerForPreviewing(with: self, sourceView: view)
		}
	}
	
}

extension RestaurantListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		if Device.isPhone {
			let cellWidth = collectionView.frame.size.width
			return CGSize(width: cellWidth, height: 135)
		} else {
			let screenRect = collectionView.frame.size.width
			let screenWidth = screenRect - 21
			let cellWidth = screenWidth / 2.0
			return CGSize(width: cellWidth, height: 135)
		}
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return manager.numberOfItems
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantListCell", for: indexPath) as! RestaurantCell
		let item = manager.restaurantItem(at: indexPath)
		
		cell.lblTitle.text = item.name
		cell.lblCity.text = item.city
		cell.lblCuisine.text = item.cuisine
		
		return cell
	}
}

extension RestaurantListViewController: UIViewControllerPreviewingDelegate {
	
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
		let restaurantDetail: UIStoryboard = UIStoryboard(name: "RestaurantDetail", bundle: nil)
		
		guard let indexPath = collectionView?.indexPathForItem(at: location),
		let cell = collectionView?.cellForItem(at: indexPath),
			let detailVC = restaurantDetail.instantiateViewController(withIdentifier: "RestaurantDetail") as? RestaurantListViewController else {
				return nil
		}
		selectedRestaurant = manager.restaurantItem(at: indexPath)
		detailVC.selectedRestaurant = selectedRestaurant
		detailVC.preferredContentSize = CGSize(width: 0, height: 528)
		previewingContext.sourceRect = cell.frame
		return detailVC
	}
	
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
		show(viewControllerToCommit, sender: self)
	}
}
