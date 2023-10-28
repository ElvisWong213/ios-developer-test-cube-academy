//
//  FeelingPicker.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI

enum FeelingKey: Codable {
    case VeryUnfair, Unfair, NotSure, Fair, VeryFair
    
    enum CodingKeys: String, CodingKey {
        case VeryUnfair = "very_unfair"
        case Unfair = "unfair"
        case NotSure = "not_sure"
        case Fair = "fair"
        case VeryFair = "very_fair"
    }
}

struct FeelingPicker: View {
    @Binding var selected: FeelingKey?
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(Feeling.list, id: \.key) { feeling in
                FeelingPickerItem(feeling: feeling, selected: $selected)
            }
        }
    }
}

#Preview {
    FeelingPicker(selected: .constant(nil))
}
