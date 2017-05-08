//
//  LocationViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/7/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
	@IBOutlet weak var tableView: UITableView!
	
	let manager = LocationDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		manager.fetch()

        // Do any additional setup after loading the view.
    }
	
}

extension LocationViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return manager.numberOfItems
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
		cell.textLabel?.text = manager.locationItem(at: indexPath)
		return cell
		
	}
}
