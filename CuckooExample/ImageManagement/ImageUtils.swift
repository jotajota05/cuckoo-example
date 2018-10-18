//
//  ImageUtils.swift
//  CuckooExample
//
//  Created by Juan Garcia on 10/16/18.
//  Copyright © 2018 Cocoaheads. All rights reserved.
//

import Foundation
import CoreImage
import UIKit

protocol ImageUtils {
	func apply(filter: FilterType, input: CGImage, completion: @escaping (UIImage?) -> Void)
}

class ImageEditor: ImageUtils {
	func apply(filter: FilterType, input: CGImage, completion: @escaping (UIImage?) -> Void) {

		let coreInputImage = CIImage(cgImage: input)
		
		var filterName = ""
		
		switch filter {
		case .blackAndWhite:
			filterName = "CIPhotoEffectNoir"
		case .sepia:
			filterName = "CISepiaTone"
		case .invert:
			filterName = "CIColorInvert"
		}
		
		DispatchQueue.global(qos: .background).async {
			let coreImageFilter = CIFilter(name: filterName)
			coreImageFilter?.setValue(coreInputImage, forKey: kCIInputImageKey)
			
			if filter == .sepia {
				coreImageFilter?.setValue(1.0, forKey: kCIInputIntensityKey)
			}
			
			if let output = coreImageFilter?.value(forKey: kCIOutputImageKey) as? CIImage {
				let filteredImage = UIImage(ciImage: output)
				completion(filteredImage)
			} else {
				completion(nil)
			}
		}
	}
}
