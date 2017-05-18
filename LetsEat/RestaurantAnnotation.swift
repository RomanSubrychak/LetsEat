//
//  RestaurantAnnotation.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import MapKit

public class RestaurantAnnotation: NSObject {
	
	public var name: String?
	public var cuisines = [String]()
	public var latitude: Double?
	public var longitude: Double?
	public var address: String?
	public var postalCode: String?
	public var state: String?
	public var imageURL: String?
	
	public var data: [String: AnyObject]?
	
	public init(dict: [String: AnyObject]) {
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
	
	public var restaurantItem: RestaurantItem {
		guard let restaurantData = data else {
			return RestaurantItem()
		}
		return RestaurantItem(dict: restaurantData)
	}
}

extension RestaurantAnnotation: MKAnnotation {
	
	public var title: String? {
		return name ?? ""
	}
	
	public var subtitle: String? {
		return cuisines.isEmpty ? "" : cuisines.joined(separator: ",")
	}
	
	public var coordinate: CLLocationCoordinate2D {
		guard let lat = latitude, let long = longitude else {
			return CLLocationCoordinate2D()
		}
		return CLLocationCoordinate2D(latitude: lat, longitude: long)
	}

}
