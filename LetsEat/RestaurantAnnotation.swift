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
	
	var data: [String: AnyObject]?
	
	init(dict: [String: AnyObject]) {
		name = dict["name"] as? String
		
		if let cuisines = dict["cuisines"] as? [AnyObject] {
   			for data in cuisines {
				if let cuisine = data["cuisine"] as? String {
					self.cuisines.append(cuisine)
				}
   			}
		}
		latitude = dict["lat"] as? Double
		longitude = dict["lng"] as? Double
		address = dict["address"] as? String
		postalCode = dict["postal_code"] as? String
		state = dict["state"] as? String
		imageURL = dict["image_url"] as? String
		
		data = dict
	}
	
	var restaurantItem: RestaurantItem {
		guard let restaurantData = data else {
			return RestaurantItem()
		}
		return RestaurantItem(dict: restaurantData)
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
