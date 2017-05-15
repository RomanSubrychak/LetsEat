//
//  ReviewDataManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/14/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class ReviewDataManager: NSObject {
	
	private var items: [ReviewItem] = []
	
	let manager = CoreDataManager()
	
	func fetchReview(by id: Int) {
		
		if !items.isEmpty {
			items.removeAll()
		}
		
		for data in manager.fetchReviews(by: id) {
			items.append(data)
		}
	}
	
	var numberOfItems: Int {
		return items.count
	}
	
	func reviewItem(at indexPath: IndexPath) -> ReviewItem {
		return items[indexPath.item]
	}
	
	func getLatestReview() -> ReviewItem {
		guard let item = items.first else {
			return ReviewItem()
		}
		return item
	}
}
