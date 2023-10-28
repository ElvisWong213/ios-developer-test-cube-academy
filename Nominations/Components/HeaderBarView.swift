//
//  HeaderBarView.swift
//  Nominations
//
//  Created by Sam Davis on 20/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI

/// Basic custom header bar for use in place of a navigation bar.
/// 
/// Can display a `String` title, or the 3 Sided Cube logo icon.
///
/// - Note: Does not include navigation features.
struct HeaderBarView: View {
    
    /// Title for this header bar.
    /// If not provided, displays logo.
    var title: String? = nil

    var body: some View {
        Group {
            if let title {
                Text(title)
                    .style(.navigationBar)
                    .foregroundStyle(.white)
            } else {
                Image(.logoIcon)
                    .resizable()
                    .foregroundStyle(.white)
                    .frame(size: 35)
                    .padding(.bottom, 12)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(
            Color.black
                .ignoresSafeArea()
                .shadow(.strong)
        )
    }
}

// MARK: - Previews

#Preview("HeaderBarView (logo)") {
    VStack {
        HeaderBarView()
        Spacer()
    }
}

#Preview("HeaderBarView (title)") {
    VStack {
        HeaderBarView(title: "Title")
        Spacer()
    }
}
