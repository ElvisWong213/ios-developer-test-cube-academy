//
//  FeelingPicker.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI

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

struct FeelingPicker: View {
    @Binding var selected: FeelingKey
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(Feeling.list, id: \.key) { feeling in
                FeelingPickerItem(feeling: feeling, selected: $selected)
            }
        }
    }
}

#Preview {
    FeelingPicker(selected: .constant(.Null))
}
