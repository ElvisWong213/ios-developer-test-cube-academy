//
//  HomeViewModelTests.swift
//  NominationsTests
//
//  Created by Elvis on 29/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import XCTest
@testable import Nominations

@MainActor
final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    
    override func setUp() {
        viewModel = HomeViewModel()
        executionTimeAllowance = 5
    }

    func testFetchData() {
        Task {
            viewModel.isRefreshed = true
            viewModel.fetchData()
            XCTAssertEqual(viewModel.nominationlist.count, 0)
            XCTAssertEqual(viewModel.nomineeList.count, 70)
            XCTAssertEqual(viewModel.isRefreshed, false)
        }
        
    }
    
    func testRemoveNomination() async throws {
        let nomination: NominationRequest = .init(nomineeId: "9a4bd093-e74c-4918-87cc-0c689cca78bf", reason: "ABC", process: .VeryFair)
        let nominationResponse = try await Network.makeRequest(request: .createNomination(nominationRequest: nomination)) as CreateNominationResponse
        viewModel.nominationlist.append(nominationResponse.data)
        viewModel.removeNomination(atOffsets: .init(integer: 0))
    }

}
