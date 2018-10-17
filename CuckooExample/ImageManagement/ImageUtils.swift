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

protocol ImageUtil {
	func apply(filter: FilterType, input: UIImage, completion: (UIImage?) -> Void)
}
