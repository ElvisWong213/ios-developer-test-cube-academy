//
//  Nomination.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation

// MARK: - Response
struct AllNominationsResponse: Codable {
    let data: [NominationResponse]
}

struct CreateNominationResponse: Codable {
    let data: NominationResponse
}

struct NominationResponse: Codable {
    let nominationId: String
    let nomineeId: String
    let reason: String
    let process: String
    let dateSubmitted: String
    let closingDate: String
    
    enum CodingKeys: String, CodingKey {
        case reason, process
        case nominationId = "nomination_id"
        case nomineeId = "nominee_id"
        case dateSubmitted = "date_submitted"
        case closingDate = "closing_date"
        
    }
}

// MARK: - Request
struct NominationRequest: Codable {
    var nomineeId: String
    var reason: String
    var process: FeelingKey
    
    enum CodingKeys: String, CodingKey {
        case reason, process
        case nomineeId = "nominee_id"
    }
    
    var isAllFilledOut: Bool {
        get {
            return !nomineeId.isEmpty && !reason.isEmpty && !process.isEmpty
        }
    }
    
    var isAPartFilledOut: Bool {
        get {
            return !nomineeId.isEmpty || !reason.isEmpty || !process.isEmpty
        }
    }
}
