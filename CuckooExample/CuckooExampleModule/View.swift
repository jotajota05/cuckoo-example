//
//  ViewController.swift
//  CuckooExample
//
//  Created by Juan Garcia on 2018-10-15.
//  Copyright © 2018 Cocoaheads. All rights reserved.
//

import UIKit

class View: UIViewController {
	
	@IBOutlet var photoImageView: UIImageView!
	
	@IBOutlet var blackAndWhiteSwitch: UISwitch!
	@IBOutlet var sepiaSwitch: UISwitch!
	@IBOutlet var invertSwitch: UISwitch!
	
	weak var eventHandler: EventHandler?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		Router.shared.viewDidLoad(with: self)
		self.eventHandler?.changeImage()
    }

	@IBAction func didTapChangePhotoButton(_ sender: Any) {
		self.eventHandler?.changeImage()
	}
	
	@IBAction func didTapSaveButton(_ sender: Any) {
		self.eventHandler?.save()
	}
	
	@IBAction func didTapResetButton(_ sender: Any) {
		self.eventHandler?.reset()
	}
	
	@IBAction func didChangeBlackAndWhiteSwitchValue(_ sender: Any) {
		self.eventHandler?.activate(filter: .blackAndWhite)
	}
	
	@IBAction func didChangeSepiaSwitchValue(_ sender: Any) {
		self.eventHandler?.activate(filter: .sepia)
	}
	
	@IBAction func didChangeInvertSwitchValue(_ sender: Any) {
		self.eventHandler?.activate(filter: .invert)
	}
}

extension View: UserInterface {
	
	func update(image: UIImage?) {
		DispatchQueue.main.async {
			self.photoImageView.image = image
		}
	}
	
	func setActive(filter: FilterType) {
		self.blackAndWhiteSwitch.setOn(filter == .blackAndWhite, animated: true)
		self.sepiaSwitch.setOn(filter == .sepia, animated: true)
		self.invertSwitch.setOn(filter == .invert, animated: true)
	}
	
	func resetFilters() {
		self.blackAndWhiteSwitch.setOn(false, animated: true)
		self.sepiaSwitch.setOn(false, animated: true)
		self.invertSwitch.setOn(false, animated: true)
	}
}
