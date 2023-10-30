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
        // The reasone of using scroll view is scroll view is refreashable. And VStack don't.
        // If user have a bad network connection, they cannot fetch the list of nominations.
        // This view will show up and the user can refresh the view and fetch the list again.
        // It can be done by using List, but it cannot match the figma design.
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
            if isRefreshed == false {
                isRefreshed = true
            }
        }
    }
}

#Preview {
    GeometryReader { geo in
        ListEmptyView(height: geo.size.height, isRefreshed: .constant(false))
    }
}
