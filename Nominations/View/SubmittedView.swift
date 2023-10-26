//
//  SubmittedView.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct SubmittedView: View {
    var body: some View {
        VStack {
            HeaderBarView(title: "Nomination Submitted")
            Image(.group)
                .resizable()
                .scaledToFit()
            Group {
                Text("Nomination submitted")
                    .multilineTextAlignment(.center)
                    .textCase(.uppercase)
                    .font(TextStyle.boldHeadlineLarge.font)
                    .bold()
                Text("Thank you for taking the time to fill out this form! Why not nominate another cube?")
                    .font(TextStyle.body.font)
            }
            .padding()
            Spacer()
            VStack(spacing: 0) {
                PrimaryButton(text: "Create new nomination") {
                    
                }
                SecondaryButtton(text: "Back to home") {
                    
                }
            }
            .customShadow()
        }
    }
}

#Preview {
    SubmittedView()
}
