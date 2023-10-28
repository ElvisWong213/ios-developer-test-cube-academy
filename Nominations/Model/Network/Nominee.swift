//
//  Nominee.swift
//  Nominations
//
//  Created by Elvis on 27/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation

struct AllNominees: Codable {
    let data: [Nominee]
}

struct Nominee: Codable, Hashable {
    let nomineeId: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case nomineeId = "nominee_id"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
