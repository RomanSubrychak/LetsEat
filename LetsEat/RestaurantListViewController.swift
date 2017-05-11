//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!
	
	let manager = RestaurantDataManager()
	
	
	var selectedRestaurant: RestaurantItem?
	var selectedCity: String?
	var selectedType: String?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
	
	func showRestaurantDetail(segue: UIStoryboardSegue) {
		if let viewController = segue.destination as? RestaurantDetailViewController, let index = collectionView.indexPathsForSelectedItems?.first {
			selectedRestaurant = manager.restaurantItem(at: index)
			viewController.selectedRestaurant = selectedRestaurant
		}
	}
}

extension RestaurantListViewController: UICollectionViewDataSource {
	
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
