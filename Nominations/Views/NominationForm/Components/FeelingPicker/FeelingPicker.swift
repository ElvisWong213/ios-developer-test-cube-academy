//
//  FeelingPicker.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI

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
