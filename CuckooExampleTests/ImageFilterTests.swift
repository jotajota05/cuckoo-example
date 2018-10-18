//
//  ImageFilterTests.swift
//  CuckooExampleTests
//
//  Created by Juan Garcia on 10/17/18.
//  Copyright © 2018 Cocoaheads. All rights reserved.
//

import XCTest
@testable import CuckooExample
import Cuckoo

class ImageFilterTests: XCTestCase {
	
	func testBlackAndWhiteFilterApplication() {
		let presenter = Presenter()
		
		presenter.userInterface = MockUserInterface()
		presenter.imageEditor = MockImageEditor()
		
		guard let mockEditor = presenter.imageEditor as? MockImageEditor,
			let mockUserInterface = presenter.userInterface as? MockUserInterface else { XCTFail(); return }
		
		var filterWasApplied = false
		var properFilterWasApplied = false
		var userInterfaceWasUpdated = false
		
		let testImage = UIImage(named: "city1")
		
		presenter.originalImage = testImage
		
		stub(mockUserInterface) { stub in
			stub.setActive(filter: any()).then { filter in
				properFilterWasApplied = (filter == .blackAndWhite)
			}
		}
		
		stub(mockEditor) { stub in
			stub.apply(filter: any(), input: any(), completion: any()).then { filter, inputImage, result in
				filterWasApplied = true && (filter == .blackAndWhite) && (inputImage == testImage?.cgImage)
				result(testImage)
			}
		}
		
		stub(mockUserInterface) { stub in
			stub.update(image: any()).then { imageToUpdate in
				userInterfaceWasUpdated = (imageToUpdate == testImage)
			}
		}
		
		presenter.activate(filter: .blackAndWhite)
		
		XCTAssertTrue(filterWasApplied && userInterfaceWasUpdated && properFilterWasApplied)
	}
	
	func testSepiaFilterApplication() {
		let presenter = Presenter()
		
		presenter.userInterface = MockUserInterface()
		presenter.imageEditor = MockImageEditor()
		
		guard let mockEditor = presenter.imageEditor as? MockImageEditor,
			let mockUserInterface = presenter.userInterface as? MockUserInterface else { XCTFail(); return }
		
		var filterWasApplied = false
		var properFilterWasApplied = false
		var userInterfaceWasUpdated = false
		
		let testImage = UIImage(named: "city1")
		
		presenter.originalImage = testImage
		
		stub(mockUserInterface) { stub in
			stub.setActive(filter: any()).then { filter in
				properFilterWasApplied = (filter == .sepia)
			}
		}
		
		stub(mockEditor) { stub in
			stub.apply(filter: any(), input: any(), completion: any()).then { filter, inputImage, result in
				filterWasApplied = true && (filter == .sepia) && (inputImage == testImage?.cgImage)
				result(testImage)
			}
		}
		
		stub(mockUserInterface) { stub in
			stub.update(image: any()).then { imageToUpdate in
				userInterfaceWasUpdated = (imageToUpdate == testImage)
			}
		}
		
		presenter.activate(filter: .sepia)
		
		XCTAssertTrue(filterWasApplied && userInterfaceWasUpdated && properFilterWasApplied)
	}
	
	func testInvertFilterApplication() {
		let presenter = Presenter()
		
		presenter.userInterface = MockUserInterface()
		presenter.imageEditor = MockImageEditor()
		
		guard let mockEditor = presenter.imageEditor as? MockImageEditor,
			let mockUserInterface = presenter.userInterface as? MockUserInterface else { XCTFail(); return }
		
		var filterWasApplied = false
		var properFilterWasApplied = false
		var userInterfaceWasUpdated = false
		
		let testImage = UIImage(named: "city1")
		
		presenter.originalImage = testImage
		
		stub(mockUserInterface) { stub in
			stub.setActive(filter: any()).then { filter in
				properFilterWasApplied = (filter == .invert)
			}
		}
		
		stub(mockEditor) { stub in
			stub.apply(filter: any(), input: any(), completion: any()).then { filter, inputImage, result in
				filterWasApplied = true && (filter == .invert) && (inputImage == testImage?.cgImage)
				result(testImage)
			}
		}
		
		stub(mockUserInterface) { stub in
			stub.update(image: any()).then { imageToUpdate in
				userInterfaceWasUpdated = (imageToUpdate == testImage)
			}
		}
		
		presenter.activate(filter: .invert)
		
		XCTAssertTrue(filterWasApplied && userInterfaceWasUpdated && properFilterWasApplied)
	}
}
