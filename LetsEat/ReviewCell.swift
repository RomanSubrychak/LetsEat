//
//  ReviewCell.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/14/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
	
	@IBOutlet weak var imageReview: UIImageView!
	@IBOutlet weak var imgRating: UIImageView!
	@IBOutlet weak var lblUser: UILabel!
	@IBOutlet weak var lblDate: UILabel!
	@IBOutlet weak var lblReview: UILabel!
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
