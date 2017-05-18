//
//  RestaurantItem.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation
import MapKit

public struct RestaurantItem {
	public var name:String?
	public var city:String?
	public var address:String?
	public var price:Int?
	public var state:String?
	public var longitude:Float?
	public var latitude:Float?
	public var cuisines = [String]()
	public var image: String?
	public var restaurantID: Int?
	public var data: [String: AnyObject]?
	
	public var cuisine: String? {
		return cuisines.isEmpty ? "" : cuisines.joined(separator: ",")
	}
	
	public var annotation: RestaurantAnnotation {
		guard let restaurantData = data else {
			return RestaurantAnnotation(dict: [:])
		}
		return RestaurantAnnotation(dict: restaurantData)
	}
}

extension RestaurantItem {
	public init(dict: [String: AnyObject]) {
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
