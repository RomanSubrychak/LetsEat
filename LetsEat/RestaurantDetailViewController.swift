//
//  RestaurantDetailViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {
	
	var selectedRestaurant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
		print(selectedRestaurant as Any)
    }

  }
