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
    @EnvironmentObject var homeVM: HomeViewModel

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
                .padding([.horizontal, .bottom])
            VStack(spacing: 0) {
                SecondaryButtton(text: "Yes, leave page") {
                    homeVM.createNewNomination = false
                }
                SecondaryButtton(text: "Cancel") {
                    showAlert.toggle()
                }
            }
            .customShadow()
            .padding(.top)
        }
    }
}

#Preview {
    LeavePageAlertView(showAlert: .constant(false))
        .environmentObject(HomeViewModel())
}
