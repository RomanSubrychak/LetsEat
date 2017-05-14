//
//  FilterManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/13/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

class FilterManager: DataManager {
	
	private var items = [FilterItem]()
	
	func fetch() {
		for data in load(file: "FilterData") {
			items.append(FilterItem(dict: data))
		}
	}
	
	var numberOfItems: Int {
		return items.count
	}
	
	func filterItemAtIndexPath(_ index: IndexPath) -> FilterItem {
		return items[index.item]
	}
}
