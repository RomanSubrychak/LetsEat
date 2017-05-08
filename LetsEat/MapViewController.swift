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

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
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
}
