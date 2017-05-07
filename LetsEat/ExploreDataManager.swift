//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

class ExploreDataManager {
	
	fileprivate var items = [ExploreItem]()
	
	func fetch() {
		for data in loadData() {
			items.append(ExploreItem(dict: data))
		}
	}
	
	var numberOfItems: Int {
		return items.count
	}
	
	func explore(at index: IndexPath) -> ExploreItem {
		return items[index.item]
	}
	
	fileprivate func loadData() -> [[String: AnyObject]] {
		guard let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"),
			let items = NSArray(contentsOfFile: path) else {
			return [[:]]
		}
		return items as! [[String: AnyObject]]
	}
}
