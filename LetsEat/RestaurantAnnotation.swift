//
//  RestaurantAnnotation.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class RestaurantAnnotation: NSObject {
	var name: String?
	var cuisines = [String]()
	var latitude: Double?
	var longitude: Double?
	var address: String?
	var postalCode: String?
	var state: String?
	var imageURL: String?
}
