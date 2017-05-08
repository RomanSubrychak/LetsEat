//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation
import MapKit

class MapDataManager: DataManager {
	
	fileprivate var items = [RestaurantAnnotation]()
	
	var annotations: [RestaurantAnnotation] {
		return items;
	}
	
	func fetch(completion: (_ anotations: [RestaurantAnnotation]) -> () ) {
		if !items.isEmpty {
			items.removeAll()
		}
		for data in load(file: "MapLocations") {
			items.append(RestaurantAnnotation(dict: data))
		}
		
		completion(items)
	}
	
	func currentLocation(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
		guard let item = items.first else {
			return MKCoordinateRegion()
		}
		let span = MKCoordinateSpanMake(latDelta, longDelta)
		return MKCoordinateRegion(center: item.coordinate, span: span)
	}
}
