//
//  LocationDataManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

class LocationDataManager {
	
	private var arrLocations = [String]()
	
	func fetch() {
		for location in loadData() {
			arrLocations.append(location)
		}
	}
	
	var numberOfItems: Int {
		return arrLocations.count
	}
	
	func locationItem(at index: IndexPath) -> String {
		return arrLocations[index.item]
	}
	
	func loadData() -> [String] {
		guard let path = Bundle.main.path(forResource: "Location", ofType: "plist"),
			let locations = NSArray(contentsOfFile: path) else {
				return []
		}
		return locations as! [String]
	}
}
