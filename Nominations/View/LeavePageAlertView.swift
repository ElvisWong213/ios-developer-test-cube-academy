//
//  LeavePageAlertView.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct LeavePageAlertView: View {
    @Binding var showAlert: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Are you sure?")
                .textCase(.uppercase)
                .font(TextStyle.boldHeadlineSmall.font)
                .bold()
                .padding()
            Text("If you leave this page, you will loose any progress made.")
                .font(TextStyle.body.font)
                .padding()
            VStack(spacing: 0) {
                SecondaryButtton(text: "Yes, leave page") {
                    
                }
                SecondaryButtton(text: "Cancel") {
                    showAlert.toggle()
                }
            }
            .customShadow()
        }
    }
}

#Preview {
    LeavePageAlertView(showAlert: .constant(false))
}
