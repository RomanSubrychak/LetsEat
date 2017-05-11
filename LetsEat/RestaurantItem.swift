//
//  RestaurantItem.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation
import MapKit

struct RestaurantItem {
	var name:String?
	var city:String?
	var address:String?
	var price:Int?
	var state:String?
	var longitude:Float?
	var latitude:Float?
	var cuisines = [String]()
	var image: String?
	var restaurantID: Int?
	var data: [String: AnyObject]?
	
	var cuisine: String? {
		return cuisines.isEmpty ? "" : cuisines.joined(separator: ",")
	}
	
	var annotation: RestaurantAnnotation {
		guard let restaurantData = data else {
			return RestaurantAnnotation(dict: [:])
		}
		return RestaurantAnnotation(dict: restaurantData)
	}
}

extension RestaurantItem {
	init(dict: [String: AnyObject]) {
		name  = dict["name"] as? String
		city = dict["city"] as? String
		address  = dict["address"] as? String
		price = dict["price"] as? Int
		state = dict["state"] as? String
		longitude = dict["lng"] as? Float
		latitude = dict["lat"] as? Float
		restaurantID = dict["id"] as? Int
		image = dict["image"] as? String
		
		if let cuisines = dict["cuisines"] as? [AnyObject] {
			for data in cuisines {
				if let cuisine = data["cuisine"] as? String {
					self.cuisines.append(cuisine)
				}
			}
		}
		
		data = dict
	}
}
