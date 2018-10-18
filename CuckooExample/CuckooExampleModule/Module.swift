//
//  Module.swift
//  CuckooExample
//
//  Created by Juan Garcia on 10/16/18.
//  Copyright © 2018 Cocoaheads. All rights reserved.
//

import Foundation
import UIKit

protocol UserInterface: class {
	var eventHandler: EventHandler? { get set }
	
	func update(image: UIImage?)
	func setActive(filter: FilterType)
	func resetFilters()
}

protocol EventHandler: class {
	func activate(filter: FilterType)
	func changeImage()
	func reset()
	func save()
}

protocol Broker {
	func fetchImage(completion: (UIImage?) -> Void)
	func save(image: UIImage, success: (() -> Void)?, failure: ((Error) -> Void)?)
}
