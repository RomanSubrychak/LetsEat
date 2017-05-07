//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/6/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

	@IBOutlet weak var colectionView: UICollectionView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension ExploreViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 20
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath)
		return cell
	}
}
