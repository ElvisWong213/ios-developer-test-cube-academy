//
//  NominationFormViewModelTests.swift
//  NominationsTests
//
//  Created by Elvis on 29/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import XCTest
@testable import Nominations

final class NominationFormViewModelTests: XCTestCase {
    var viewModel: NominationFormViewModel!
    
    override func setUp() {
        viewModel = NominationFormViewModel()
    }
    
    func testReset() {
        viewModel.showSheet = true
        viewModel.nominationRequest = NominationRequest(nomineeId: "asd", reason: "asd", process: .Fair)
        viewModel.showAlert = true
        viewModel.isLoading = true
        viewModel.reset()
        
        XCTAssertEqual(viewModel.showAlert, false)
        XCTAssertEqual(viewModel.nominationRequest.isAPartFilledOut, false)
        XCTAssertEqual(viewModel.showAlert, false)
        XCTAssertEqual(viewModel.isLoading, false)
    }
    
    func testSubmitForm() async {
        viewModel.nominationRequest = NominationRequest(nomineeId: "9a4bd093-e74c-4918-87cc-0c689cca78bf", reason: "ABC", process: .VeryFair)

        let response = await viewModel.submitForm()
        
        XCTAssertEqual(response?.data.nomineeId, viewModel.nominationRequest.nomineeId)
        XCTAssertEqual(response?.data.reason, viewModel.nominationRequest.reason)
        XCTAssertEqual(response?.data.process, viewModel.nominationRequest.process.rawValue)
    }

}
