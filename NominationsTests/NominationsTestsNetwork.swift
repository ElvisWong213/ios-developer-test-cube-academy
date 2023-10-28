//
//  NominationsTestsNetwork.swift
//  NominationsTests
//
//  Created by Elvis on 27/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import XCTest
@testable import Nominations

final class NominationsTestsNetwork: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        Task {
            let list = try await Network.makeRequest(request: .getAllNominees) as AllNominees
            XCTAssertEqual(list.data.count, 70)
        }
    }

}
