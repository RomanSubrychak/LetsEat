//
//  DataManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

class DataManager {
	func load(file name: String) -> [[String: AnyObject]] {
		guard let path = Bundle.main.path(forResource: name, ofType: "plist"),
			let items = NSArray(contentsOfFile: path) else {
				return [[:]]
		}
		return items as! [[String: AnyObject]]
	}
}
