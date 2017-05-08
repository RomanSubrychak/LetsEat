//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

class MapDataManager: DataManager {
	
	fileprivate var items = [RestaurantAnnotation]()
	
	var annotations: [RestaurantAnnotation] {
		return items;
	}
	
	func fetch(completion: (_ anotations: [RestaurantAnnotation]) -> () ) {
		if !items.isEmpty {
			items.removeAll()
		}
		for data in load(data: "MapLocations") {
			items.append(RestaurantAnnotation(dict: data))
		}
		
		completion(items)
	}
}
