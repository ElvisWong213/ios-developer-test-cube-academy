//
//  Feeling.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation
import SwiftUI

struct Feeling {
    let feelingImage: Image
    let text: String
    let key: FeelingKey
    
    static let list: [Feeling] = [
        .init(feelingImage: Image(.veryUnfair), text: "Very Unfair", key: .VeryUnfair),
        .init(feelingImage: Image(.unfair), text: "Unfair", key: .Unfair),
        .init(feelingImage: Image(.notSure), text: "Not Sure", key: .NotSure),
        .init(feelingImage: Image(.fair), text: "Fair", key: .Fair),
        .init(feelingImage: Image(.veryFair), text: "Very Fair", key: .VeryFair)
    ]
}

enum FeelingKey: String, Codable {
    case VeryUnfair, Unfair, NotSure, Fair, VeryFair, Null
    
    var rawValue: String  {
        switch self {
        case .VeryUnfair:
            return "very_unfair"
        case .Unfair:
            return "unfair"
        case .NotSure :
            return "not_sure"
        case .Fair:
            return "fair"
        case .VeryFair:
            return "very_fair"
        case .Null:
            return ""
        }
    }
    
    var isEmpty: Bool {
        get {
            return self == .Null
        }
    }
}
