//
//  ExploreItem.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/6/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

struct ExploreItem {
	
	var name: String?
	var image: String?
	
}

extension ExploreItem {
	
	init(dict: [String: AnyObject]) {
		self.name = dict["name"] as? String
		self.image = dict["image"] as? String
		
	}
}
