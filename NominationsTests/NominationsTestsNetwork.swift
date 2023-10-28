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

    func testGetAllNominees() async throws {
        let list = try await Network.makeRequest(request: .getAllNominees) as AllNominees
        XCTAssertEqual(list.data.count, 70)
    }
    
    func testCreateNomination() async throws {
        let nomination: NominationRequest = .init(nomineeId: "9a4bd093-e74c-4918-87cc-0c689cca78bf", reason: "ABC", process: .VeryFair)
        let response = try await Network.makeRequest(request: .createNomination(nominationRequest: nomination)) as CreateNominationResponse
        XCTAssertEqual(response.data.nomineeId, nomination.nomineeId)
        XCTAssertEqual(response.data.reason, nomination.reason)
        XCTAssertEqual(response.data.process, nomination.process.rawValue)
    }
    
    func testRemoveNomination() async throws {
        let nomination: NominationRequest = .init(nomineeId: "9a4bd093-e74c-4918-87cc-0c689cca78bf", reason: "ABC", process: .VeryFair)
        let nominationResponse = try await Network.makeRequest(request: .createNomination(nominationRequest: nomination)) as CreateNominationResponse
        let response = try await Network.makeRequest(request: .deleteNomination(nominationId: nominationResponse.data.nominationId)) as DeleteNominationResponse
        XCTAssertEqual(response.data, "Nomination deleted successfully")
    }

}
