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
    let height: CGFloat
    @Binding var isRefreshed: Bool
    
    var body: some View {
        ScrollView {
            ZStack {
                Color(.cubeLightGrey)
                    .ignoresSafeArea()
                VStack {
                    NominationsHeaderView()
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
            .frame(height: height)
        }
        .refreshable {
            isRefreshed = true
        }
    }
}

#Preview {
    GeometryReader { geo in
        ListEmptyView(height: geo.size.height, isRefreshed: .constant(false))
    }
}
