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

    override func viewDidLoad() {
        super.viewDidLoad()
		initialize()
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



