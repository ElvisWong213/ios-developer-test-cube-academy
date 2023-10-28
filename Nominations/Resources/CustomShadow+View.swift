//
//  CustomShadow.swift
//  Nominations
//
//  Created by Elvis on 26/10/2023.
//  Copyright © 2023 3 Sided Cube (UK) Ltd. All rights reserved.
//

import Foundation
import SwiftUI
import CubeFoundationSwiftUI

struct CustomShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background() {
                Color.white
                    .shadow(FigmaShadow.strong)
                    .mask(Rectangle().padding(.top, -10))
            }
    }
}

extension View {
    func customShadow() -> some View {
        modifier(CustomShadow())
    }
}