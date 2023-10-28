//
//  FeelingPickerItem.swift
//  Nominations
//
//  Created by Elvis on 28/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import SwiftUI
import CubeFoundationSwiftUI

struct FeelingPickerItem: View {
    let feeling: Feeling
    @Binding var selected: FeelingKey?
    let size = UIScreen.main.bounds.width / 13
    
    var body: some View {
        Button {
            selected = feeling.key
        } label: {
            HStack {
                Group {
                    feeling.feelingImage
                        .padding()
                    Text(feeling.text)
                        .font(TextStyle.boldHeadlineSmallest.font)
                }
                .foregroundStyle(.black)
                Spacer()
                ZStack {
                    Circle()
                        .padding(4)
                        .opacity(selected == feeling.key ? 1 : 0)
                    Circle()
                        .stroke(lineWidth: 2)
                        .foregroundStyle(selected == feeling.key ? .accent : .cubeDarkGrey)
                }
                .frame(width: size, height: size)
                .padding()
            }
            .border(selected == feeling.key ? .black : .cubeMidGrey, width: 2)
            .background() {
                if selected == feeling.key {
                    Color.white
                        .shadow(FigmaShadow.strong)
                }
            }
        }
    }
}

#Preview {
    FeelingPickerItem(feeling: Feeling.list[0], selected: .constant(nil))
}
