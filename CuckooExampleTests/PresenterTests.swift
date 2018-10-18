//
//  CuckooExampleTests.swift
//  CuckooExampleTests
//
//  Created by Juan Garcia on 2018-10-15.
//  Copyright © 2018 Cocoaheads. All rights reserved.
//

import XCTest
@testable import CuckooExample
import Cuckoo

class PresenterTests: XCTestCase {

	func testChangePicture() {
		
		// Given
		let presenter = Presenter()

        presenter.userInterface = MockUserInterface()
		presenter.broker = MockBroker()
		
		guard let mockBroker = presenter.broker as? MockBroker,
			let mockUserInterface = presenter.userInterface as? MockUserInterface else { XCTFail(); return }
		
		var fetchImageCallWasMade = false
		var userInterfaceWasUpdated = false

        let testImage = UIImage(named: "city1")
		
		// When
		stub(mockBroker) { stub in
			when(stub.fetchImage(completion: any())).then { completion in
                completion(testImage)
				fetchImageCallWasMade = true
                verify(mockUserInterface).update(image: any())
			}
		}

		stub(mockUserInterface) { stub in
			when(stub.update(image: any())).then { image in
                userInterfaceWasUpdated = (image == testImage)
			}
		}
		
		presenter.changeImage()
		
		// Then
		XCTAssertTrue(fetchImageCallWasMade && userInterfaceWasUpdated)
	}

    func testResetFilter() {

        // Given
        let presenter = Presenter()
        presenter.userInterface = MockUserInterface()

        guard let mockUserInterface = presenter.userInterface as? MockUserInterface else { XCTFail(); return }

        var filtersWereReset = false
        var userInterfaceWasUpdated = false

        // When
        stub(mockUserInterface) { stub in
            when(stub.resetFilters()).then {
                filtersWereReset = true
            }
        }

        stub(mockUserInterface) { stub in
            when(stub.update(image: any())).then { _ in
                userInterfaceWasUpdated = true
            }
        }

        presenter.reset()

        // Then
        XCTAssertTrue(filtersWereReset && userInterfaceWasUpdated)
    }

    func testSavePictureSucessfully() {

        // Given
        let presenter = Presenter()
        presenter.broker = MockBroker()

        guard let mockBroker = presenter.broker as? MockBroker else { XCTFail(); return }

        var saveApiWasCalled = false

        presenter.filteredImage = UIImage(named: "city1")

        // When
        stub(mockBroker) { stub in
            when(stub.save(image: any(), success: any(), failure: any())).then { _, success, _ in
                success?()
                saveApiWasCalled = true
            }
        }

        presenter.save()

        // Then
        XCTAssertTrue(saveApiWasCalled)
    }
}
