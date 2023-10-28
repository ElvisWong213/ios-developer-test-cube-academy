//
//  FormTextView.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct FormTextView<Content: View>: View {
    @ViewBuilder let titleText: Content
    let bodyText: String
    let secondTitleText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            titleText
                .textCase(.uppercase)
                .font(TextStyle.boldHeadlineSmall.font)
                .bold()
            Text(bodyText)
                .font(TextStyle.body.font)
                .lineSpacing(5)
                .padding(.bottom)
            if !secondTitleText.isEmpty {
                HStack {
                    Text("* ")
                        .foregroundStyle(.accent) +
                    Text(secondTitleText)
                }
                .font(TextStyle.boldHeadlineSmallest.font)
                .bold()
            }
        }
    }
}

#Preview {
    FormTextView(titleText: { Text("I'd like to nominate...") }, bodyText: "Please select a cube who you fell has done someting honourable this month or just all round has a great work ethic.", secondTitleText: "Cube's name")
}
