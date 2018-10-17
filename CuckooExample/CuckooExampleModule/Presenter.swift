//
//  CuckooExamplePresenter.swift
//  CuckooExample
//
//  Created by Juan Garcia on 10/16/18.
//  Copyright © 2018 Cocoaheads. All rights reserved.
//

import Foundation
import UIKit

class Presenter: EventHandler {
	
	var userInterface: UserInterface?
	var broker: Broker?
	var imageEditor: ImageEditor?
	
	var originalImage: UIImage?
	var filteredImage: UIImage?
	
	func activate(filter: FilterType) {
		self.userInterface?.setActive(filter: filter)
		
		guard let inputImage = self.originalImage?.cgImage else { return }
		self.imageEditor?.apply(filter: filter, input: inputImage) { result in
			guard let filteredImage = result else { return }
			self.filteredImage = filteredImage
			self.userInterface?.update(image: filteredImage)
		}
	}
	
	func changeImage() {
		self.broker?.fetchImage { result in
			guard let newImage = result else { return }
			self.originalImage = newImage
			self.filteredImage = newImage
			self.userInterface?.update(image: newImage)
		}
	}
	
	func reset() {
		self.userInterface?.resetFilters()
		self.userInterface?.update(image: self.originalImage)
	}
	
	func save() {
		guard let imageToSave = self.filteredImage else { return }
		self.broker?.save(image: imageToSave, success: nil, failure: nil)
	}
	
	
}
