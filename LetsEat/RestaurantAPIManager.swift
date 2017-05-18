//
//  RestaurantAPIManager.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/8/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

public struct RestaurantAPIManager {
	
	public static func loadJSON(file name: String) -> [[String: AnyObject]] {
		var items = [[String: AnyObject]]()
		
		guard let path = Bundle.main.path(forResource: name, ofType: "json"),
			let data = NSData(contentsOfFile: path) else {
				return [[:]]
		}
		
		do {
			let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as AnyObject
			if let restaurants = json["restaurants"] as? [[String: AnyObject]] {
				items = restaurants as [[String: AnyObject]]
			}
		} catch {
			print("error serializing JSON: \(error.localizedDescription)")
			items = [[:]]
		}
		return items
	}
}
