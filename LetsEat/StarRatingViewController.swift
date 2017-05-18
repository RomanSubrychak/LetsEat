//
//  StarRatingViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/14/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit

class StarRatingViewController: UIViewController {
	
	@IBOutlet weak var pickerView: UIPickerView!
	
	var selectedRating = Rating.zero
	var pickerDataSource: [Rating] = [.five, .fourHalf, .four, .threeHalf, .three, .twoHalf, .two, .oneHalf, .one, .half, .zero]

    override func viewDidLoad() {
        super.viewDidLoad()
		
		initialize()
    }
	
	func initialize() {
		setDefaults()
	}
	
	func setDefaults() {
		pickerView.dataSource = self
		pickerView.delegate = self
		if let index = pickerDataSource.index(of: selectedRating) {
			pickerView.selectRow(index, inComponent: 0, animated: false)
		}
	}
}

extension StarRatingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerDataSource.count
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		let frame = CGRect(x: 0, y: 0, width: pickerView.rowSize(forComponent: component).width - 10, height: pickerView.rowSize(forComponent: component).height)
		let ratingView = RatingView(frame: frame, value: pickerDataSource[row])
		
		return ratingView
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		selectedRating = pickerDataSource[row]
	}
}
