//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {
	
	@IBOutlet weak var lblName: UILabel!
	@IBOutlet weak var lblCuisine: UILabel!
	@IBOutlet weak var lblHeaderAddress: UILabel!
	@IBOutlet weak var lblTableDetails: UILabel!
	@IBOutlet weak var lblAddress: UILabel!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var reviewsContainer: UIView!
	@IBOutlet weak var lblUser: UILabel!
	@IBOutlet weak var txtReview: UITextView!
	@IBOutlet weak var imgRating: UIImageView!
	@IBOutlet weak var btnHeart: UIBarButtonItem!
	@IBOutlet weak var noReviewsContainer: UIView!
	
	var selectedRestaurant: RestaurantItem?
	let manager = ReviewDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
		initialize()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		checkReviews()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier {
			switch identifier {
			case Segue.showReview.rawValue:
				showReview(segue: segue)
			case Segue.showAllReviews.rawValue:
				showAllReviews(segue: segue)
			default:
				print("Segue is not added")
			}
		}
	}
	
	func showReview(segue: UIStoryboardSegue) {
		if let viewController = segue.destination as? CreateReviewViewControllerTableViewController {
			viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
		}
	}
	
	func showAllReviews(segue: UIStoryboardSegue) {
		if let viewController = segue.destination as? ReviewListViewController {
			viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
		}
	}
	
	func setupLabels() {
		guard let restaurant = selectedRestaurant else {
			return
		}
		
		lblName.text = restaurant.name
		lblCuisine.text = restaurant.cuisine
		lblAddress.text = restaurant.address
		lblHeaderAddress.text = restaurant.address
		
		lblTableDetails.text = "Table for 7 tonight at 10:00PM"
		
	}
	
	func initialize() {
		setupLabels()
		setupMap()
	}
	
	func setupMap() {
		guard let annotation = selectedRestaurant?.annotation,
		let lat = annotation.latitude, let long = annotation.longitude else {
			return
		}
		
		let location = CLLocationCoordinate2D(
			latitude: lat,
			longitude: long
		)
		
		let span = MKCoordinateSpanMake(0.5, 0.5)
		let region = MKCoordinateRegion(center: location, span: span)
		mapView.setRegion(region, animated: true)
		mapView.addAnnotations([annotation])
		
	}
	
	func checkReviews() {
		if let id = selectedRestaurant?.restaurantID {
			manager.fetchReview(by: id)
		}
		
		let count = manager.numberOfItems
		
		if count > 0  {
			noReviewsContainer.isHidden = true
		}
		
		let item = manager.getLatestReview()
		lblUser.text = item.name
		txtReview.text = item.customerReivew
		if let rating = item.rating {
			imgRating.image = UIImage(named: Rating.image(rating: rating))
		}
	}

}

extension RestaurantDetailViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let identifier = "customPin"
		guard !annotation.isKind(of: MKAnnotation.self) else {
			return nil
		}
		
		var annotationView: MKAnnotationView?
		
		if let customAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
			annotationView = customAnnotation
			annotationView?.annotation = annotation
		} else {
			let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			annotationView = av
		}
		
		if let annotationView = annotationView {
			annotationView.image = UIImage(named: "custom-annotation")
		}
		
		return annotationView
	}
	
}



