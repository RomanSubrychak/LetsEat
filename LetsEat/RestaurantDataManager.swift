//
//  RestaurantDataManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/9/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

public class RestaurantDataManager {
	
	private var items = [RestaurantItem]()
	
	public func fetch(by location: String, withFilter: String = "All", completionHandler: () -> Swift.Void) {
		var restaurants = [RestaurantItem]()
		for restaurant in RestaurantAPIManager.loadJSON(file: location) {
			restaurants.append(RestaurantItem(dict: restaurant))
		}
		
		if withFilter != "All" {
			items = restaurants.filter { $0.cuisines.contains(withFilter) }
		} else {
			items = restaurants
		}
		completionHandler()
	}
	
	public init() {}
	
	public var numberOfItems: Int {
		return items.count
	}
	
	public func restaurantItem(at index: IndexPath) -> RestaurantItem {
		return items[index.item]
	}
}
