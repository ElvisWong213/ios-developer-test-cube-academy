//
//  HomeView.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct HomeView: View {
    @State var list: [String] = []
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderBarView()
            if list.isEmpty {
                NominationsHeaderView()
                ListEmptyView()
            } else {
                List {
                    NominationsHeaderView()
                        .listRowInsets(EdgeInsets())
                    ForEach(list, id: \.self) { _ in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Title")
                                    .font(TextStyle.bodyBold.font)
                                    .bold()
                                Spacer()
                                Text("Info")
                                    .font(TextStyle.body.font)
                            }
                            .padding(.vertical)
                            Spacer()
                        }
                    }
                }
                .listStyle(.plain)
            }
            PrimaryButton(text: "create new nomination") {
                list.append("Hi")
            }
            .customShadow()
        }
        .background(.cubeLightGrey)
    }
}

#Preview {
    HomeView()
}
