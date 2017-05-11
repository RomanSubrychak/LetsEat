//
//  MapViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
	
	@IBOutlet weak var mapView: MKMapView!
	let manager = MapDataManager()
	var selectedRestaurant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier {
			switch identifier {
			case Segue.showDetail.rawValue:
				showRestaurantDetail(segue: segue)
			default:
				print("Segue not added")
			}
		}
	}
	
	func showRestaurantDetail(segue: UIStoryboardSegue) {
		if let viewController = segue.destination as? RestaurantDetailViewController, let restaurant = selectedRestaurant {
			viewController.selectedRestaurant = restaurant
		}
	}
	
	func initialize() {
		mapView.delegate = self
		manager.fetch { [unowned self]
			annotations in self.addMap(annotations) }
			
	}
	
	func addMap(_ annotations: [RestaurantAnnotation]) {
		mapView.setRegion(manager.currentLocation(latDelta: 0.5, longDelta: 0.5), animated: true)
		mapView.addAnnotations(manager.annotations)
	}
	
	func unwindLocationCancel(segue: UIStoryboardSegue) {
		
	}
	
	func unwindLocationDone(segue: UIStoryboardSegue) {
		
	}
}

extension MapViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let identifier = "customPin"
		
		guard !annotation.isKind(of: MKAnnotation.self) else {
			return nil
		}
		
		var annotationView: MKAnnotationView?
		
		if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
			annotationView = customAnnotationView
			annotationView?.annotation = annotation
		} else {
			let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
			annotationView = av
		}
		
		if let annotationView = annotationView {
			annotationView.canShowCallout = true
			annotationView.image = UIImage(named: "custom-annotation")
		}
		
		return annotationView
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		guard let annotation = mapView.selectedAnnotations.first else {
			return
		}
		let data = annotation as! RestaurantAnnotation
		selectedRestaurant = data.restaurantItem
		
		self.performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
	}
}
