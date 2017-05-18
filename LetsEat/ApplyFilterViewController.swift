//
//  ApplyFilterViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/13/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class ApplyFilterViewController: UIViewController {
	
	var image: UIImage?
	var thumbnail: UIImage?
	let manager = FilterManager()
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var imgExample: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		initialize()
		
    }
	
	func initialize() {
		manager.fetch()
		
		if let image = self.image, let thumb = self.thumbnail {
			createScrollContent(img: thumb)
			imgExample.image = image
		}
	}
	
	func createScrollContent(img: UIImage) {
		DispatchQueue.main.async { [unowned self] in
			let size = CGFloat(102)
			var currentViewOffset = CGFloat(10)
			
			for index in 0..<self.manager.numberOfItems {
				let item = self.manager.filterItemAtIndexPath(IndexPath(item: index, section: 0))
				let frame = CGRect(x: currentViewOffset, y: 0, width: size, height: 124)
				let subView = PhotoItem(frame: frame, image: img, item: item)
				
				subView.delegate = self
				
				self.scrollView.addSubview(subView)
				currentViewOffset += (size + 10)
			}
			self.scrollView.showsHorizontalScrollIndicator = false
			self.scrollView.contentSize = CGSize(width: CGFloat(self.manager.numberOfItems) * 113, height: size)
		}
	}
}

extension ApplyFilterViewController: ImageFiltering, ImageFilteringDelegate {
	
	func filterSelected(item: FilterItem) {
		let filteredImg = image
		
		if let filterName = item.filter, let img = filteredImg {
			if filterName != "None" {
				imgExample.image = apply(filter: filterName, originalImage: img)
			} else {
				imgExample.image = img
			}
		}
	}
}
