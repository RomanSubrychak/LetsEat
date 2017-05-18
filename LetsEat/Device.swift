//
//  Device.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/17/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

struct Device {
	static var currentDevice: UIDevice {
		struct Singleton {
			static let device = UIDevice.current
		}
		return Singleton.device
	}
	
	static var isPhone: Bool {
		return currentDevice.userInterfaceIdiom == .phone
	}
	
	static var isPad: Bool {
		return currentDevice.userInterfaceIdiom == .pad
	}
}
