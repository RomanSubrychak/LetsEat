//
//  RestaurantAnnotation.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import MapKit

class RestaurantAnnotation: NSObject {
	
	var name: String?
	var cuisines = [String]()
	var latitude: Double?
	var longitude: Double?
	var address: String?
	var postalCode: String?
	var state: String?
	var imageURL: String?
	
	init(dict: [String: AnyObject]) {
		name = dict["name"] as? String
		
		if let cuisines = dict["cuisine"] as? [String] {
			self.cuisines = cuisines
		}
		
		latitude = dict["lat"] as? Double
		longitude = dict["lng"] as? Double
		address = dict["address"] as? String
		postalCode = dict["postal_code"] as? String
		state = dict["state"] as? String
		imageURL = dict["image_url"] as? String
	}
}

extension RestaurantAnnotation: MKAnnotation {
	
	var title: String? {
		return name ?? ""
	}
	
	var subtitle: String? {
		return cuisines.isEmpty ? "" : cuisines.joined(separator: ",")
	}
	
	var coordinate: CLLocationCoordinate2D {
		guard let lat = latitude, let long = longitude else {
			return CLLocationCoordinate2D()
		}
		return CLLocationCoordinate2D(latitude: lat, longitude: long)
	}

}
