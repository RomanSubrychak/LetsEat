//
//  RatingView.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/14/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class RatingView: UIView {
	
	@IBOutlet private var contentView:UIView?
	@IBOutlet weak var imgRating: UIImageView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	init(frame: CGRect, value: Rating) {
		super.init(frame: frame)
		
		setupDefaults()
		setup(rating: value)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupDefaults()
	}
	
	private func setupDefaults() {
		Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)
		guard let content = contentView else {
			return
		}
		
		content.frame = self.bounds
		content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		self.addSubview(content)
	}
	
	func setup(rating: Rating) {
		imgRating.image = UIImage(named: Rating.image(rating: rating.rawValue))
	}
	
}
