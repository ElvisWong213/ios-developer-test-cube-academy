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
    @ViewBuilder let title: Content
    let description: String
    let fieldTitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            title
                .textCase(.uppercase)
                .font(TextStyle.boldHeadlineSmall.font)
                .bold()
            Text(description)
                .font(TextStyle.body.font)
                .lineSpacing(5)
                .padding(.bottom)
            if !fieldTitle.isEmpty {
                HStack {
                    Text("* ")
                        .foregroundStyle(.accent) +
                    Text(fieldTitle)
                }
                .font(TextStyle.boldHeadlineSmallest.font)
                .bold()
            }
        }
    }
}

#Preview {
    FormTextView(title: { Text("I'd like to nominate...") }, description: "Please select a cube who you fell has done someting honourable this month or just all round has a great work ethic.", fieldTitle: "Cube's name")
}
