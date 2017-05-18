//
//  Rating.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/14/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import Foundation

enum Rating: Float {
	case zero = 0.0
	case half = 0.5
	case one = 1.0
	case oneHalf = 1.5
 	case two = 2.0
 	case twoHalf = 2.5
	case three = 3.0
 	case threeHalf = 3.5
 	case four = 4.0
 	case fourHalf = 4.5
 	case five = 5.0
	
	static func image(rating: Float) -> String {
		var images = ["0star", "05star", "1star", "15star", "2star", "25star", "3star",  "35star", "4star", "45star", "5star"]
		var values = [Float]()
		
		for i in stride(from: 0, through: 5, by: 0.5) {
			values.append(Float(i))
		}
		
		guard let index = values.index(of: rating) else {
			return ""
		}
		
		return images[index]
	}
}
