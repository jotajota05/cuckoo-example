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

        // Given
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

        // When
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

        // Then
		XCTAssertTrue(filterWasApplied && userInterfaceWasUpdated && properFilterWasApplied)
	}
	
	func testSepiaFilterApplication() {

        // Given
		let presenter = Presenter()
		
		presenter.userInterface = MockUserInterface()
		presenter.imageEditor = MockImageEditor()
		
		guard let mockEditor = presenter.imageEditor as? MockImageEditor,
			let mockUserInterface = presenter.userInterface as? MockUserInterface else { XCTFail(); return }
		
		var filterWasApplied = false
		var properFilterSwitchWasActivated = false
		var userInterfaceWasUpdatedWithTestImage = false
		
		let testImage = UIImage(named: "city1")
		
		presenter.originalImage = testImage

        // When
		stub(mockUserInterface) { stub in
			stub.setActive(filter: any()).then { filter in
				properFilterSwitchWasActivated = (filter == .sepia)
			}
		}
		
		stub(mockEditor) { stub in
			stub.apply(filter: any(), input: any(), completion: any()).then { filter, inputImage, completion in
				filterWasApplied = (filter == .sepia) && (inputImage == testImage?.cgImage)
				completion(testImage)
                verify(mockUserInterface).update(image: any())
			}
		}
		
		stub(mockUserInterface) { stub in
			stub.update(image: any()).then { imageToUpdate in
				userInterfaceWasUpdatedWithTestImage = (imageToUpdate == testImage)
			}
		}
		
		presenter.activate(filter: .sepia)
        verify(mockUserInterface).setActive(filter: any())

        // Then
		XCTAssertTrue(filterWasApplied && userInterfaceWasUpdatedWithTestImage && properFilterSwitchWasActivated)
	}
	
	func testInvertFilterApplication() {

        // Given
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

        // When
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

        // Then
		XCTAssertTrue(filterWasApplied && userInterfaceWasUpdated && properFilterWasApplied)
	}
}
