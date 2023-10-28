//
//  AllNominations.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation

struct AllNominations: Codable {
    let data: [Nomination]
}

struct Nomination: Codable {
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
