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

class CuckooExampleTests: XCTestCase {

	func testChangePicture() {
		let presenter = Presenter()
		presenter.userInterface = MockUserInterface()
		presenter.broker = MockBroker()
		
		guard let mockBroker = presenter.broker as? MockBroker,
			let mockUserInterface = presenter.userInterface as? MockUserInterface else { XCTFail(); return }
		
		var fetchImageCallWasMade = false
		var userInterfaceWasUpdated = false
		
		stub(mockBroker) { stub in
			when(stub.fetchImage(completion: any())).then { _ in
				fetchImageCallWasMade = true
			}
		}
		
		stub(mockUserInterface) { stub in
			when(stub.update(image: any())).then { _ in
				userInterfaceWasUpdated = true
			}
		}
		
		presenter.changeImage()
		
		XCTAssertTrue(fetchImageCallWasMade && userInterfaceWasUpdated)
	}

}
