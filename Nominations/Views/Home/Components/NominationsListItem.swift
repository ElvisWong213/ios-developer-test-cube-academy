//
//  NominationsListItem.swift
//  Nominations
//
//  Created by Elvis on 27/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct NominationsListItem: View {
    let name: String
    let reason: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(TextStyle.bodyBold.font)
                    .bold()
                    .padding(.bottom)
                Text(reason)
                    .font(TextStyle.body.font)
                    .lineLimit(1)
            }
            .padding(.vertical)
            Spacer()
        }
    }
}

#Preview {
    NominationsListItem(name: "Elvis", reason: "Hello world")
}
