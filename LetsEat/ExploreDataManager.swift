//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

class ExploreDataManager: DataManager {
	
	fileprivate var items = [ExploreItem]()
	
	func fetch() {
		for data in load(data: "ExploreData") {
			items.append(ExploreItem(dict: data))
		}
	}
	
	var numberOfItems: Int {
		return items.count
	}
	
	func explore(at index: IndexPath) -> ExploreItem {
		return items[index.item]
	}
	
}
