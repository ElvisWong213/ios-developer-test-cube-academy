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

    @Binding var showSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            FormTextView(title: { Text("Are you sure?") }, description: "If you leave this page, you will loose any progress made.", fieldTitle: "")
                .padding()
            VStack(spacing: 0) {
                SecondaryButtton(text: "Yes, leave page") {
                    homeVM.path = []
                }
                SecondaryButtton(text: "Cancel") {
                    showSheet.toggle()
                }
            }
            .customShadow()
            .padding(.top)
        }
    }
}

#Preview {
    LeavePageAlertView(showSheet: .constant(false))
        .environmentObject(HomeViewModel())
}
