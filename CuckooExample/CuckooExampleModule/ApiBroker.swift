//
//  ApiBroker.swift
//  CuckooExample
//
//  Created by Juan Garcia on 10/16/18.
//  Copyright © 2018 Cocoaheads. All rights reserved.
//

import Foundation
import UIKit

class ImageBroker: Broker {
	
	private var imageNumber = 0
	
	func fetchImage(completion: (UIImage?) -> Void) {
		completion(UIImage(named: "city\(imageNumber % 6)"))
		imageNumber += 1
	}
	
	func save(image: UIImage, success: (() -> Void)?, failure: ((Error) -> Void)?) {
		success?()
	}
}
