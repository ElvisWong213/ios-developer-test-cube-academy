//
//  ListEmptyView.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI


struct ListEmptyView: View {
    var body: some View {
        ZStack {
            Color(.cubeLightGrey)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image(systemName: "tray.fill")
                    .font(.system(size: 100))
                    .padding()
                Text("Once you submit a nomination, you will be able to see it here.")
                    .multilineTextAlignment(.center)
                    .font(TextStyle.boldHeadlineMedium.font)
                    .bold()
                    .textCase(.uppercase)
                    .padding()
                Spacer()
            }
            .foregroundStyle(.cubeDarkGrey)
        }
    }
}

#Preview {
    ListEmptyView()
}
