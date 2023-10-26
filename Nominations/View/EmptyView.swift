//
//  EmptyView.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI


struct EmptyView: View {
    var body: some View {
        ZStack {
            Color(.cubeLightGrey)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "tray.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.cubeDarkGrey)
                Text("Once you submit a nomination, you will be able to see it here.")
                    .multilineTextAlignment(.center)
                    .font(TextStyle.boldHeadlineLarge.font)
                    .bold()
                    .foregroundStyle(.cubeDarkGrey)
                    .textCase(.uppercase)
                    .padding()
                Spacer()
            }
        }
    }
}

#Preview {
    EmptyView()
}
