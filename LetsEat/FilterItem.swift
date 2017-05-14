//
//  FilterItem.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/13/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

struct FilterItem {
	var filter: String?
	var name: String?
}

extension FilterItem {
	
	init(dict: [String: AnyObject]) {
		self.name = dict["name"] as? String
		self.filter = dict["filter"] as? String
	}
}
