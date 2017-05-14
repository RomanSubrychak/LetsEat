//
//  CreateReviewViewControllerTableViewController.swift
//  LetsEat
//
//  Created by Roman Subrichak on 5/12/17.
//  Copyright © 2017 Roman Subrychak. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class CreateReviewViewControllerTableViewController: UITableViewController {
	
	@IBOutlet weak var tvReview: UITextView!
	@IBOutlet weak var tfName: UITextField!
	@IBOutlet weak var btnThumbnail: UIButton!
	@IBOutlet weak var btnRating: UIButton!
	
	var image: UIImage?
	var thumbnail: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
		
		initialize()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier! {
		case Segue.applyFilter.rawValue:
			showApplyFilter(with: segue)
		default:
			print("not segue added")
		}
	}
	
	func initialize() {
		requestAccess()
		updateTextView()
	}
	
	func updateTextView() {
		tvReview.layer.borderColor = UIColor.lightGray.cgColor
		tvReview.layer.borderWidth = 0.5
		tvReview.layer.cornerRadius = 5.0
		tvReview.text = ""
	}
	
	func showApplyFilter(with segue: UIStoryboardSegue) {
		guard let navController = segue.destination as? UINavigationController,
			let viewController = navController.topViewController as? ApplyFilterViewController else {
				return
		}
		viewController.image = image
		viewController.thumbnail?.image = thumbnail
	}
	
	func requestAccess() {
		AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) {
			granted in
			if granted {
				
			}
		}
	}
	
	func checkSource() {
		let cameraMediaType = AVMediaTypeVideo
		let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: cameraMediaType)
		
		switch cameraAuthorizationStatus {
		case .authorized:
			showCamerUserInterface()
		case .restricted, .denied:
			break
		case .notDetermined:
			AVCaptureDevice.requestAccess(forMediaType: cameraMediaType) { granted in
				if granted {
					self.showCamerUserInterface()
				} else {
					
				}
			}
		}
	}
	
	@IBAction func unwindReviewCancel(segue: UIStoryboardSegue) {
	
	}
	
	@IBAction func unwindRatingSave(segue: UIStoryboardSegue) {
		
	}
	
	@IBAction func unwindFilterSave(segue: UIStoryboardSegue) {
		if segue.source is ApplyFilterViewController {
			if let thumbnail = thumbnail {
				btnThumbnail.setImage(thumbnail, for: .normal)
			}
		}
	}
	
	@IBAction func onPhotoTapped(_ sender: AnyObject) {
		checkSource()
	}

}

extension CreateReviewViewControllerTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func showCamerUserInterface() {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		
		#if (arch(i386) || arch(x86_64)) && os(iOS)
			imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
		#else
			imagePicker.sourceType = UIImagePickerControllerSourceType.camera
			imagePicker.showsCameraControls = true
		#endif
		
		imagePicker.mediaTypes = [kUTTypeImage as String]
		imagePicker.allowsEditing = true
		self.present(imagePicker, animated: true, completion: nil)
	}
	
	func generate(image: UIImage, ratio: CGFloat)  -> UIImage {
		let size = image.size
		let croppedSize: CGSize?
		var offsetX: CGFloat = 0.0
		var offsetY: CGFloat = 0.0
		
		if size.width > size.width {
			offsetX = (size.height - size.width) / 2
			croppedSize = CGSize(width: size.height, height: size.height)
		} else {
			offsetY = (size.width - size.height) / 2
			croppedSize = CGSize(width: size.width, height: size.width)
		}
		
		guard let cropped = croppedSize, let cgImage = image.cgImage else {
			return UIImage()
		}
		
		let clippedRect = CGRect(x: offsetX * -1, y: offsetY * -1, width: cropped.width, height: cropped.height)
		let imgRef = cgImage.cropping(to: clippedRect)
		
		let rect = CGRect(x: 0.0, y: 0.0, width: ratio, height: ratio)
		UIGraphicsBeginImageContext(rect.size)
		
		if let ref = imgRef {
			UIImage(cgImage: ref).draw(in: rect)
		}
		
		let thumb = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return thumb ?? UIImage()
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let image = info[UIImagePickerControllerEditedImage] as? UIImage
		
		if let img = image {
			let genImage = generate(image: img, ratio: CGFloat(102))
			self.btnThumbnail.imageView?.image = genImage
			self.thumbnail = genImage.copy() as? UIImage
			self.image = generate(image: img, ratio: CGFloat(752))
		}
		
		picker.dismiss(animated: true) { [unowned self] in
			self.performSegue(withIdentifier: Segue.applyFilter.rawValue, sender: self)
		}
	}
}
